using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebBanSua.Data;
using WebBanSua.ViewModels;
using X.PagedList.Extensions;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace WebBanSua.Controllers
{
    public class ProductsController : Controller
    {
        private readonly WebBanSuaContext db;
        public ProductsController(WebBanSuaContext context) 
        {
            db = context;
        }
        /*public IActionResult Index(string? category)
        {
            var products = db.Products.AsQueryable();
            if (!string.IsNullOrEmpty(category))
            {
                products = products.Where(p => p.CategoryId == category);
            }
            var result = products.Select(p => new ProductVM
            {
                ProductId = p.ProductId,
                ProductName = p.Name ?? "Chưa có tên",
                Price = p.Price ?? 0,
                ImageUrl = p.ImageUrl ?? "",
                Description = p.Description ?? "Chưa có mô tả.",
                CategoryName = p.Category != null
            ? (p.Category.CategoryName ?? "Không rõ")
            : "Không rõ"
            });
            return View(result.ToList());
        }*/
        public IActionResult Index(string? category, int page = 1)
        {
            int pageSize = 9;
            var products = db.Products.AsQueryable();

            if (!string.IsNullOrEmpty(category))
            {
                products = products.Where(p => p.CategoryId == category);
            }

            var result = products.Select(p => new ProductVM
            {
                ProductId = p.ProductId,
                ProductName = p.Name ?? "Chưa có tên",
                Price = p.Price ?? 0,
                ImageUrl = p.ImageUrl ?? "",
                Description = p.Description ?? "Chưa có mô tả.",
                CategoryName = p.Category != null ? (p.Category.CategoryName ?? "Không rõ") : "Không rõ"
            });

            // Sử dụng IPagedList
            var pagedResult = result.ToPagedList(page, pageSize);
            return View(pagedResult);
        }
        public IActionResult Search(string? query)
        {
            var products = db.Products.AsQueryable();
            if (query != null)
            {
                products = products.Where(p => p.Name.Contains(query));
            }
            var result = products.Select(p => new ProductVM
            {
                ProductId = p.ProductId,
                ProductName = p.Name,
                Price = p.Price ?? 0,
                ImageUrl = p.ImageUrl ?? "",
                Description = p.Description,
                CategoryName = p.Category != null ? p.Category.CategoryName : "Không rõ"
            });
            return View(result.ToList());
        }

        public IActionResult Detail(string id)
        {
            var data = db.Products
                .Include(p => p.Category)
                .SingleOrDefault(p => p.ProductId == id.ToString());
            if (data == null)
            {
                TempData["Message"] = $"Không thấy sản phẩm có mã {id}";
                return Redirect("/404");
            }
            var result = new DetailProductVM
            {
                ProductId = data.ProductId,
                ProductName = data.Name,
                Price = data.Price ?? 0,
                ImageUrl = data.ImageUrl ?? "",
                Description = data.Description,
                CategoryName = data.Category != null ? data.Category.CategoryName : "Không rõ"
            };
            return View(result);
        }
    }
}
