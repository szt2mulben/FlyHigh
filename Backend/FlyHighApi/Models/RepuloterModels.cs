using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace FlyHighApi.Models
{
    [Table("repuloter")]

    public partial class RepuloterModels
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int Id { get; set; }

        [StringLength(50)]
        public string LastName { get; set; } = null!;

        [StringLength(50)]
        public string BirthsDay { get; set; } = null;

        [StringLength(50)]
        public string Country { get; set; } = null!;
    }
}
