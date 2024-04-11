using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace FlyHighApi.Models
{
    public partial class Repuloter
    {
        [Key]
        [Column(TypeName = "int(11)")]
        public int Id { get; set; }

        [StringLength(50)]
        public string LastName { get; set; }

        public DateTime BirthsDay { get; set; }

        [StringLength(50)]
        public string Country { get; set; }


    }
}
