using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FlyHighApi.Models
{
    [Table("jegyek")]
    public partial class JegyekModel
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int jegy_id { get; set; }

        [StringLength(50)]
        public string megrendelo_nev { get; set; } = null!;

        [StringLength(50)]
        public string Indulas_hely { get; set; } = null!;

        [StringLength(50)]
        public string erkezes_hely { get; set; } = null!;

        [StringLength(50)]
        public string indulasido { get; set; } = null!;

        [Column(TypeName = "int(11)")]
        public int? utazok { get; set; }

        [StringLength(50)]
        public string osztaly { get; set; } = null!;

        [Column(TypeName = "int(11)")]
        public int? ar { get; set; } 

        [StringLength(50)]
        public string erkezesido { get; set; } = null!;

        [StringLength(50)]
        public string SorSzek { get; set; } = null!;




    }
}
