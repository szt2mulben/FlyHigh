using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace FlyHighApi.Models
{
    public partial class orszagok
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int Id { get; set; }

        [StringLength(50)]
        public string? Orszag_nev { get; set; }

    }
}
