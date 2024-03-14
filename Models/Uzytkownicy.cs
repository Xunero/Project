using Microsoft.AspNetCore.Identity;

namespace FilmLibraryApp.Models
{
    public class Uzytkownik : IdentityUser
    {
        public string UserName { get; set; }
        public string Email { get; set; }
        public bool CzyAdministrator { get; set; }
    }
}