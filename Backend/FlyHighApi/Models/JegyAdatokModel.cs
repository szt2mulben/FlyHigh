using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace FlyHighApi.Models
{
    [Table("jegyadatok")]

    public partial class JegyAdatokModel
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int jegy_id { get; set; }

        [StringLength(50)]
        public string? honnan { get; set; }

        [StringLength(50)]
        public string? hova { get; set; }

        public DateTime? ido { get; set; }

        [StringLength(50)]
        public string? utazok { get; set; }

        [StringLength(50)]
        public string? osztaly { get; set; }

    }
}
