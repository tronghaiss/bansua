using System.ComponentModel.DataAnnotations;

namespace WebBanSua.ViewModels
{
    public class LoginVM
    {
        [Display(Name ="Tên đăng nhập")]
        [Required(ErrorMessage ="Chưa nhập tên đăng nhập")]
        [MaxLength(10,ErrorMessage ="Tối đa 10 ký tự")]
        public string UserId { get; set; }

        [Display(Name = "Mật khẩu")]
        [Required(ErrorMessage = "Chưa nhập mật khẩu")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}