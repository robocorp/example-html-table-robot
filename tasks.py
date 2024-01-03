from robocorp.tasks import task
from robocorp.browser import browser, Page, BrowserContext
from robocorp import log
from html_tables import read_table_from_html, Table

def open_page(ctx: BrowserContext, url: str) -> Page:
  page = ctx.new_page()
  page.goto(url)
  return page

def get_html_table(page: Page) -> str:
  locator = page.locator("table#customers")
  locator.wait_for()
  return locator.evaluate("(e) => e.outerHTML")

def log_table(table: Table) -> None:
  dimensions = table.dimensions()
  log.info(f"Table dimensions are {dimensions[0]} columns and { dimensions[1]} rows")
  for header in table.headers:
    log.console_message(f"{', '.join(header)}\n", kind="regular")
  for row in table.rows:
    log.console_message(f"{', '.join(row)}\n", kind="regular")

@task
def read_html_table() -> None:
  ctx = browser().new_context()

  try:
    page = open_page(ctx, 'https://www.w3schools.com/html/html_tables.asp')
    html_table = get_html_table(page)
    table = read_table_from_html(html_table)
    log_table(table)
  finally:
    ctx.close()