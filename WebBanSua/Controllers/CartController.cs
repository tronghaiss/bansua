using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion.Internal;
using WebBanSua.Data;
using WebBanSua.ViewModels;
using WebBanSua.Helpers;

namespace WebBanSua.Controllers
{
    public class CartController : Controller
    {
        private readonly WebBanSuaContext db;

        public CartController(WebBanSuaContext context) {
            db = context;
        }

        public List<CartItem> Cart => HttpContext.Session.Get<List<CartItem>>(MySetting.CART_KEY) ?? new List<CartItem>();

        public IActionResult Index()
        {
            return View(Cart);
        }

        public IActionResult AddToCart(string id, int quantity = 1)
        {
            var cart = Cart;
            var item = cart.SingleOrDefault(p => p.ProductId == id);
            if (item == null)
            {
                var product = db.Products.SingleOrDefault(p => p.ProductId == id);
                if (product == null) {
                    TempData["Message"] = $"Không tìm thấy sản phẩm có mã {id}";
                    return Redirect("/404");
                }
                item = new CartItem
                {
                    ProductId = product.ProductId,
                    Name = product.Name,
                    Price = product.Price ?? 0,
                    ImageUrl = product.ImageUrl ?? string.Empty,
                    SoLuong = quantity
                };
                cart.Add(item);
            }
            else
            {
                item.SoLuong += quantity;
            }

            HttpContext.Session.Set(MySetting.CART_KEY, cart);

            return RedirectToAction("Index");
        }
        public IActionResult RemoveCart(string id)
        {
            var cart = Cart;
            var item = cart.SingleOrDefault(p => p.ProductId == id);
            if (item != null)
            {
                cart.Remove(item);
                HttpContext.Session.Set(MySetting.CART_KEY, cart);
            }
            return RedirectToAction("Index");
        }
    }
}
