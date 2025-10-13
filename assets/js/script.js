// Sidebar toggle for docs navigation (only on pages with sidebar)
const sidebarToggle = document.querySelector('.sidebar-toggle');
const docsNav = document.querySelector('.docs-nav');

if (sidebarToggle) {
    sidebarToggle.addEventListener('click', function() {
        docsNav.classList.toggle('active');
        this.textContent = docsNav.classList.contains('active') ? '✖ Close' : '📋 Menu';
    });

    // Close menu when clicking a link on mobile
    document.querySelectorAll('.docs-nav a').forEach(link => {
        link.addEventListener('click', () => {
            if (window.innerWidth <= 1200) {
                docsNav.classList.remove('active');
                sidebarToggle.textContent = '📋 Menu';
            }
        });
    });
}

// Mobile menu toggle for navbar (works on all pages)
const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
const navLinks = document.querySelector('.nav-links');

if (mobileMenuToggle) {
    mobileMenuToggle.addEventListener('click', function() {
        navLinks.classList.toggle('active');
        const icon = this.querySelector('span');
        icon.textContent = navLinks.classList.contains('active') ? '✖' : '☰';
    });

    // Close menu when clicking a link
    document.querySelectorAll('.nav-links a').forEach(link => {
        link.addEventListener('click', () => {
            navLinks.classList.remove('active');
            mobileMenuToggle.querySelector('span').textContent = '☰';
        });
    });

    // Close menu when clicking outside
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.nav-content')) {
            navLinks.classList.remove('active');
            if (mobileMenuToggle.querySelector('span')) {
                mobileMenuToggle.querySelector('span').textContent = '☰';
            }
        }
    });
}
