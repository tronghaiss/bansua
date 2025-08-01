using System;
using System.Collections.Generic;

namespace WebBanSua.Data;

public partial class Brand
{
    public string BrandId { get; set; } = null!;

    public string? BrandName { get; set; }

    public string? Origin { get; set; }

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
