using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using FilmLibraryApp.Models;
using Microsoft.AspNetCore.Authorization;
using System.Linq;
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

        [Authorize]
        public async Task<IActionResult> Index()
        {
            var filmy = await _context.Filmy.ToListAsync();
            return View(filmy);
        }

        [Authorize(Roles = "Pracownik,Administrator")]
        public IActionResult Dodaj()
        {
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "Pracownik,Administrator")]
        public async Task<IActionResult> Dodaj(Film film)
        {
            if (ModelState.IsValid)
            {
                _context.Filmy.Add(film);
                await _context.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(film);
        }

        [Authorize(Roles = "Pracownik,Administrator")]
        public async Task<IActionResult> Edytuj(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var film = await _context.Filmy.FindAsync(id);
            if (film == null)
            {
                return NotFound();
            }
            return View(film);
        }

        [HttpPost]
        [Authorize(Roles = "Pracownik,Administrator")]
        public async Task<IActionResult> Edytuj(int id, Film film)
        {
            if (id != film.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                _context.Entry(film).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(film);
        }

        [Authorize(Roles = "Pracownik,Administrator")]
        public async Task<IActionResult> Usun(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var film = await _context.Filmy.FindAsync(id);
            if (film == null)
            {
                return NotFound();
            }

            return View(film);
        }

        [HttpPost, ActionName("Usun")]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Pracownik,Administrator")]
        public async Task<IActionResult> PotwierdzUsuniecie(int id)
        {
            var film = await _context.Filmy.FindAsync(id);
            _context.Filmy.Remove(film);
            await _context.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        [Authorize(Roles = "Pracownik,Administrator")]
        public IActionResult DodajTworce()
        {
            // Logika dodawania twórców
        }

        [Authorize(Roles = "Pracownik,Administrator")]
        public IActionResult DodajWytwornie()
        {
            // Logika dodawania wytwórni
        }

        [Authorize(Roles = "Administrator")]
        public IActionResult UsunKonto()
        {
            // Logika usuwania konta
        }

        [Authorize(Roles = "Administrator")]
        public IActionResult DodajPracownika()
        {
            // Logika dodawania pracownika
        }
    }
}