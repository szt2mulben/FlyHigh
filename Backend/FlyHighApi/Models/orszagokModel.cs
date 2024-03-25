using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FlyHighApi.Models
{
    [Table("orszagok")]
    public partial class orszagokModel
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int Id { get; set; }

        [StringLength(50)]
        public string? Orszag_nev { get; set; }

    }
}
