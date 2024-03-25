using System.ComponentModel.DataAnnotations.Schema;
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

        public DateTime? ido { get; set; }

        [StringLength(50)]
        public string? utazok { get; set; }

        [StringLength(50)]
        public string? osztaly { get; set; }

    }
}
