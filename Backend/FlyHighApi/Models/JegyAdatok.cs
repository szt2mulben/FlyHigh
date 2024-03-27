using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace FlyHighApi.Models
{
    public partial class JegyAdatok
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int jegy_id { get; set; }

        [StringLength(50)]
        public string? honnan { get; set; }

        [StringLength(50)]
        public string? hova { get; set; }

        public DateTime? ido { get; set; }

    }
}
