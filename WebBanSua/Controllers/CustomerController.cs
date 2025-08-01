using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Reflection.Metadata.Ecma335;
using System.Security.Claims;
using System.Threading.Tasks;
using WebBanSua.Data;
using WebBanSua.ViewModels;

namespace WebBanSua.Controllers
{
    public class CustomerController : Controller
    {
        private readonly WebBanSuaContext db;

        public CustomerController(WebBanSuaContext context) 
        {
            db = context;
        }
        #region Register
        
        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Register(RegisterVM model)
        {
            if (ModelState.IsValid)
            {
                var user = new User
                {
                    UserId = model.UserId,
                    FullName = model.FullName,
                    Email = model.Email,
                    Password = model.Password,
                    Role = model.Role ?? "Customer", // fallback nếu null
                    Phone = model.Phone,
                    Address = model.Address
                };

                // Lưu vào CSDL
                db.Users.Add(user);
                db.SaveChanges();

                return RedirectToAction("Index", "Home");
            }

            return View(model);
        }
        #endregion

        #region Login
        [HttpGet]
        public IActionResult Login(string? ReturnUrl) 
        {
            ViewBag.ReturnUrl = ReturnUrl;
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Login(LoginVM model, string? ReturnUrl) 
        {
            ViewBag.ReturnUrl = ReturnUrl;
            if (ModelState.IsValid)
            {
                var customer = db.Users.SingleOrDefault(kh => kh.UserId == model.UserId);
                if(customer== null)
                {
                    ModelState.AddModelError("Lỗi", "Không tồn tại khách hàng này");
                }
                else
                {
                    if(customer.Password != model.Password)
                    {
                        ModelState.AddModelError("Lỗi", "Sai mật khẩu.");
                    }
                    else
                    {
                        var claims = new List<Claim>
                        {
                            new Claim(ClaimTypes.Name,customer.FullName),
                            new Claim(ClaimTypes.Email,customer.Email),
                            new Claim("UserId",customer.UserId),

                            //claim - role động
                            new Claim(ClaimTypes.Role,"Customer")
                        };
                        var claimsIdentity = new ClaimsIdentity(claims, CookieAuthenticationDefaults.AuthenticationScheme);
                        var claimsPrincipal = new ClaimsPrincipal(claimsIdentity);
                        await HttpContext.SignInAsync(claimsPrincipal);
                        if (Url.IsLocalUrl(ReturnUrl))
                        {
                            return Redirect(ReturnUrl);
                        }
                        else
                        {
                            return Redirect("/");
                        }
                    }
                }
            }
            return View();
        }
        #endregion

        [Authorize]
        public IActionResult Profile()
        {
            return View();
        }

        [Authorize]
        public async Task<IActionResult> LogOut()
        {
            await HttpContext.SignOutAsync();
            return Redirect("/");
        }
    }
}
