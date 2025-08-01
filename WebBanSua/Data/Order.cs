using System;
using System.Collections.Generic;

namespace WebBanSua.Data;

public partial class Order
{
    public string OrderId { get; set; } = null!;

    public string? UserId { get; set; }

    public DateTime? OrderDate { get; set; }

    public decimal? TotalAmount { get; set; }

    public string? Status { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual User? User { get; set; }
}
