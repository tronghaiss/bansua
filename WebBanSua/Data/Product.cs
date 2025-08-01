using System;
using System.Collections.Generic;

namespace WebBanSua.Data;

public partial class Product
{
    public string ProductId { get; set; } = null!;

    public string? Name { get; set; }

    public string? CategoryId { get; set; }

    public string? BrandId { get; set; }

    public decimal? Price { get; set; }

    public string? Description { get; set; }

    public int? Stock { get; set; }

    public string? ImageUrl { get; set; }

    public virtual Brand? Brand { get; set; }

    public virtual Category? Category { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();
}
