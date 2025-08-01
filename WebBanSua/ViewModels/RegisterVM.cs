using System.ComponentModel.DataAnnotations;

namespace WebBanSua.ViewModels
{
    public class RegisterVM
    {
        [Display(Name ="Tên đăng nhập")]
        [Required(ErrorMessage ="*")]
        [MaxLength(10, ErrorMessage = "Tối đa 10 ký tự")]
        public string UserId { get; set; }

        [Display(Name = "Họ và tên")]
        [MaxLength(50, ErrorMessage = "Tối đa 50 ký tự")]
        public string? FullName { get; set; }

        [Display(Name = "Email")]
        [Required(ErrorMessage = "Chưa đúng định dạng email")]
        public string? Email { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Mật khẩu")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Display(Name = "Chức năng")]
        public string? Role { get; set; } = "Customer";

        [Display(Name = "Số điện thoại")]
        [MaxLength(10, ErrorMessage = "Tối đa 10 ký tự")]
        [RegularExpression(@"0[987532]\d{8}", ErrorMessage = "Chưa đúng định dạng SĐT")]
        public string? Phone { get; set; }

        [Display(Name = "Địa chỉ")]
        public string? Address { get; set; }
    }
}
