using Microsoft.AspNetCore.Mvc;
using FilmLibraryApp.Models;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;

namespace FilmLibraryApp.Controllers
{
    public class FilmyController : Controller
    {
        private readonly ApplicationDbContext _context;

        public FilmyController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            var filmy = await _context.Filmy.ToListAsync();
            return View(filmy);
        }
    }
}