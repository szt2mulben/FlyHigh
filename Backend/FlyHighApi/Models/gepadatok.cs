using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace FlyHighApi.Models
{
   
    public partial class gepadatok
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int Id { get; set; }

        [StringLength(50)]
        public string Gepneve { get; set; }
        [Column(TypeName = "int(11)")]
        public int Foglaltturista { get; set; }
        [Column(TypeName = "int(11)")]
        public int Foglalt1oszt { get; set; }
        [Column(TypeName = "int(11)")]
        public int Elsoosztulohelyek { get; set; }
        [Column(TypeName = "int(11)")]
        public int Turistaulohelyek { get; set; }
    }
}
