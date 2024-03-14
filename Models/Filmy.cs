using System.ComponentModel.DataAnnotations;

namespace FilmLibraryApp.Models
{
    public class Film
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Tytuł jest wymagany")]
        public string Tytul { get; set; }

        [Required(ErrorMessage = "Twórca jest wymagany")]
        public string Tworca { get; set; }

        [Required(ErrorMessage = "Długość jest wymagana")]
        [Range(1, int.MaxValue, ErrorMessage = "Długość musi być większa niż 0")]
        public int Dlugosc { get; set; }

        [Required(ErrorMessage = "Opis jest wymagany")]
        public string Opis { get; set; }
    }
}