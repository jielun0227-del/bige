// 侧边栏折叠与响应式交互逻辑
document.addEventListener('DOMContentLoaded', () => {
  const sidebar = document.getElementById('sidebar');
  const mobileToggle = document.getElementById('mobileToggle');
  
  if (mobileToggle && sidebar) {
    mobileToggle.addEventListener('click', () => {
      sidebar.classList.toggle('mobile-open');
    });
  }

  // 搜索框过滤功能
  const searchInput = document.getElementById('searchInput');
  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      const query = e.target.value.toLowerCase().trim();
      const cards = document.querySelectorAll('.airport-card-modern, .article-feed-card');
      cards.forEach(card => {
        const text = card.textContent.toLowerCase();
        if (text.includes(query)) {
          card.style.display = '';
        } else {
          card.style.display = 'none';
        }
      });
    });
  }

  // 标签筛选过滤
  const filterBtns = document.querySelectorAll('.pill-btn');
  filterBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      filterBtns.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
      const tag = btn.getAttribute('data-filter');
      const cards = document.querySelectorAll('.airport-card-modern');
      
      cards.forEach(card => {
        if (tag === 'all' || card.getAttribute('data-tags')?.includes(tag)) {
          card.style.display = '';
        } else {
          card.style.display = 'none';
        }
      });
    });
  });

  // FAQ 手风琴展开与折叠交互
  const faqHeads = document.querySelectorAll('.faq-question-head');
  faqHeads.forEach(head => {
    head.addEventListener('click', () => {
      const parentCard = head.closest('.faq-card-item');
      if (parentCard) {
        parentCard.classList.toggle('active');
        const icon = head.querySelector('.faq-toggle-icon');
        if (icon) {
          icon.textContent = parentCard.classList.contains('active') ? '−' : '+';
        }
      }
    });
  });

  // 自动生成右侧文章目录 Table of Contents (TOC)
  const articleContent = document.querySelector('.article-card-main');
  const tocContainer = document.getElementById('tocList');
  if (articleContent && tocContainer) {
    const headings = articleContent.querySelectorAll('h2, h3');
    if (headings.length > 0) {
      headings.forEach((heading, index) => {
        if (!heading.id) {
          heading.id = 'heading-toc-' + index;
        }
        const li = document.createElement('li');
        li.className = 'toc-nav-item';
        if (heading.tagName.toLowerCase() === 'h3') {
          li.style.paddingLeft = '12px';
        }
        const a = document.createElement('a');
        a.href = '#' + heading.id;
        a.textContent = heading.textContent.replace(/^[\s\d.一二三四五六七八九十]+[、.]\s*/, '');
        li.appendChild(a);
        tocContainer.appendChild(li);
      });

      // 滚动高亮检测
      const tocLinks = tocContainer.querySelectorAll('a');
      window.addEventListener('scroll', () => {
        let current = '';
        headings.forEach(heading => {
          const headingTop = heading.getBoundingClientRect().top;
          if (headingTop <= 120) {
            current = heading.id;
          }
        });
        tocLinks.forEach(link => {
          link.classList.remove('active');
          if (link.getAttribute('href') === '#' + current) {
            link.classList.add('active');
          }
        });
      });
    }
  }
});
