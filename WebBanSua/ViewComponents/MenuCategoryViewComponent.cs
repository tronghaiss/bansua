using WebBanSua.Data;
using Microsoft.AspNetCore.Mvc;
using WebBanSua.ViewModels;
namespace WebBanSua.ViewComponents
{
    public class MenuCategoryViewComponent : ViewComponent
    {
        private readonly WebBanSuaContext db;

        public MenuCategoryViewComponent(WebBanSuaContext context) => db = context;
        public IViewComponentResult Invoke()
        {
            var data = db.Categories.Select(lo => new MenuCategoryVM
            {
                CategoryId = lo.CategoryId, 
                CategoryName = lo.CategoryName, 
                SoLuong = lo.Products.Count
            }).OrderBy(p => p.CategoryName);
            return View(data); //Defalt.cshtml
            //return View("Default", data);
        }
    }
}
