﻿using System;
using System.Collections.Generic;

namespace WebBanSua.Data;

public partial class User
{
    public string UserId { get; set; } = null!;

    public string? FullName { get; set; }

    public string? Email { get; set; }

    public string? Password { get; set; }

    public string? Role { get; set; }

    public string? Phone { get; set; }

    public string? Address { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
}
