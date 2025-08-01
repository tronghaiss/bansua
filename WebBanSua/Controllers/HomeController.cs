using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using WebBanSua.Data;
using WebBanSua.Models;
using WebBanSua.ViewModels;
using X.PagedList.Extensions;

namespace WebBanSua.Controllers
{
    public class HomeController : Controller
    {
        private readonly WebBanSuaContext db;
        private readonly ILogger<HomeController> _logger;

        public HomeController(WebBanSuaContext context, ILogger<HomeController> logger)
        {
            db = context;
            _logger = logger;
        }
        public IActionResult Index(string? category, int? page)
        {
            int pageSize = 8;
            int pageNumber = page ?? 1;

            // Truy vấn sản phẩm
            var products = db.Products
                .Include(p => p.Category)
                .AsQueryable();

            // Lọc theo Category nếu có
            if (!string.IsNullOrEmpty(category))
            {
                products = products.Where(p => p.CategoryId == category);
            }

            // Chuyển sang danh sách ProductVM và phân trang
            var result = products
                .Select(p => new ProductVM
                {
                    ProductId = p.ProductId,
                    ProductName = p.Name ?? "Chưa có tên",
                    Price = p.Price ?? 0,
                    ImageUrl = p.ImageUrl ?? "",
                    Description = p.Description ?? "Chưa có mô tả.",
                    CategoryName = p.Category != null
                        ? (p.Category.CategoryName ?? "Không rõ")
                        : "Không rõ"
                })
                .ToPagedList(pageNumber, pageSize);

            return View(result);
        }

        [Route("/404")]
        public IActionResult PageNotFound()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
