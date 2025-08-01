namespace WebBanSua.ViewModels
{
    public class CartItem
    {
        public string ProductId { get; set; } = null!;
        public string? Name { get; set; } = string.Empty;
        public string? ImageUrl { get; set; } = string.Empty;
        public decimal? Price { get; set; }
        public int SoLuong { get; set; }
        public decimal ThanhTien => SoLuong * (Price ?? 0);
    }
}
