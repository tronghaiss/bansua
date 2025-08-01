using Azure;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Net.NetworkInformation;
using WebBanSua.Data;
using X.PagedList;
using X.PagedList.Extensions;
using X.PagedList.Mvc.Core;

namespace WebBanSua.Areas.Admin.Controllers
{
    [Area("admin")]
    [Route("admin")]
    [Route("admin/homeadmin")]
    public class HomeAdminController : Controller
    {
        private readonly WebBanSuaContext db;

        public HomeAdminController(WebBanSuaContext context)
        {
            db = context;
        }
        [Route("")]
        [Route("index")]
        public IActionResult Index()
        {
            return View();
        }
        [Route("danhmucsanpham")]
        public IActionResult DanhMucSanPham(int? page)
        {
            int pageSize = 12;
            int pageNumber = page.HasValue && page > 0 ? page.Value : 1;

            var lstProduct = db.Products
                .AsNoTracking()
                .OrderBy(x => x.Name)
                .ToList()
                .ToPagedList(pageNumber, pageSize);

            return View(lstProduct);
        }
        private void LoadSelectLists()
        {
            ViewBag.CategoryList = new SelectList(db.Categories, "CategoryId", "CategoryName");
            ViewBag.BrandList = new SelectList(db.Brands, "BrandId", "BrandName");
        }
        [Route("ThemSanPhamMoi")]
        [HttpGet]
        public IActionResult ThemSanPhamMoi()
        {
            LoadSelectLists();
            return View();
        }
        [Route("ThemSanPhamMoi")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ThemSanPhamMoi(Product sanPham, IFormFile imageUrl)
        {
            if (ModelState.IsValid)
            {
                if (db.Products.Any(p => p.ProductId == sanPham.ProductId))
                {
                    ModelState.AddModelError("ProductID", "Mã sản phẩm đã tồn tại.");
                    LoadSelectLists();
                    return View(sanPham);
                }

                if (imageUrl != null && imageUrl.Length > 0)
                {
                    var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "hinh", "Products");
                    Directory.CreateDirectory(uploadsFolder);
                    var filePath = Path.Combine(uploadsFolder, imageUrl.FileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await imageUrl.CopyToAsync(stream);
                    }
                    sanPham.ImageUrl =  imageUrl.FileName;
                }

                db.Products.Add(sanPham);
                db.SaveChanges();
                return RedirectToAction("DanhMucSanPham");
            }

            LoadSelectLists();
            return View(sanPham);
        }

        [Route("SuaSanPham")]
        [HttpGet]
        public IActionResult SuaSanPham(string maSanPham)
        {
            LoadSelectLists();
            var sanPham = db.Products.Find(maSanPham);
            return View(sanPham);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("SuaSanPham")]
        public async Task<IActionResult> SuaSanPham(Product sanPham, IFormFile imageUrl)
        {
            if (ModelState.IsValid)
            {
                // Tìm sản phẩm gốc từ DB
                var oldProduct = db.Products.FirstOrDefault(p => p.ProductId == sanPham.ProductId);
                if (oldProduct == null)
                {
                    return NotFound();
                }
                // Cập nhật các trường cần sửa
                oldProduct.Name = sanPham.Name;
                oldProduct.Price = sanPham.Price;
                oldProduct.CategoryId = sanPham.CategoryId;
                oldProduct.BrandId = sanPham.BrandId;
                oldProduct.Description = sanPham.Description;
                oldProduct.Stock = sanPham.Stock;

                // Nếu có ảnh mới
                if (imageUrl != null && imageUrl.Length > 0)
                {
                    var uploadsFolder = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "hinh", "Products");
                    Directory.CreateDirectory(uploadsFolder);
                    var filePath = Path.Combine(uploadsFolder, imageUrl.FileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await imageUrl.CopyToAsync(stream);
                    }

                    oldProduct.ImageUrl = imageUrl.FileName; // ✅ Cập nhật ảnh mới cho sản phẩm
                }

                await db.SaveChangesAsync();
                return RedirectToAction("DanhMucSanPham", "HomeAdmin");
            }
            // Khi ModelState không hợp lệ: Lấy ảnh cũ từ DB để hiển thị lại trong view
            var existingProduct = db.Products.AsNoTracking().FirstOrDefault(p => p.ProductId == sanPham.ProductId);
            if (existingProduct != null)
            {
                sanPham.ImageUrl = existingProduct.ImageUrl;
            }
            LoadSelectLists();
            return View(sanPham);
        }

        [Route("XacNhanXoaSanPham")]
        [HttpGet]
        public IActionResult XacNhanXoaSanPham(string maSanPham)
        {
            var sanPham = db.Products.Find(maSanPham);
            if (sanPham == null)
            {
                TempData["Message"] = "Không tìm thấy sản phẩm để xác nhận xóa.";
                return RedirectToAction("DanhMucSanPham");
            }
            return View(sanPham); // Trả về view xác nhận
        }

        [Route("XoaSanPham")]
        [HttpPost]
        public IActionResult XoaSanPham(string maSanPham)
        {
            TempData["Message"] = "";

            var sanPham = db.Products.Find(maSanPham);
            if (sanPham == null)
            {
                TempData["Message"] = "Không tìm thấy sản phẩm để xóa.";
                return RedirectToAction("DanhMucSanPham", "HomeAdmin");
            }

            //// Xóa ảnh vật lý nếu có
            //if (!string.IsNullOrEmpty(sanPham.ImageUrl))
            //{
            //    var path = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "hinh", "Products", sanPham.ImageUrl);
            //    if (System.IO.File.Exists(path))
            //    {
            //        System.IO.File.Delete(path);
            //    }
            //}

            db.Products.Remove(sanPham);
            db.SaveChanges();

            TempData["Message"] = "Sản phẩm đã được xóa.";
            return RedirectToAction("DanhMucSanPham", "HomeAdmin");
        }

    }
}
