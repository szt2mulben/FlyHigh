using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace FlyHighApi.Models
{
    [Table("gepadatok")]
    public partial class GepAdatokModel
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int Id { get; set; }

        [StringLength(50)]
        public string Gepneve { get; set; } = null!;
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
