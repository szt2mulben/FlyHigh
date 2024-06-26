﻿using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace FlyHighApi.Models
{
    public partial class Jegyek
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int jegy_id { get; set; }

        [StringLength(50)]
        public string? megrendelo_nev { get; set; }

        [StringLength(50)]
        public string? Indulas_hely { get; set; }

        [StringLength(50)]
        public string? erkezes_hely { get; set; }

        [StringLength(50)]
        public string? indulasido { get; set; }

        [Column(TypeName = "int(11)")]
        public int? utazok { get; set; }

        [StringLength(50)]
        public string? osztaly { get; set; }

        [Column(TypeName = "int(11)")]
        public int? ar { get; set; }

        [StringLength(50)]
        public string? erkezesido { get; set; }

        [StringLength(50)]
        public string? SorSzek { get; set; }



    }
}
