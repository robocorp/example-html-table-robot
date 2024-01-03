from bs4 import BeautifulSoup
from dataclasses import dataclass
from typing import Tuple

@dataclass
class Table:
    headers: list[str]
    rows: [list[list[str]]]

    def dimensions(self) -> Tuple[int, int]:
        return (0 if len(self.rows) == 0 else len(self.rows[0]), len(self.rows))

def read_table_from_html(html_table: str) -> Table:
    """Parses and returns the given HTML table as a Table structure.

    :param html_table: Table HTML markup.
    """
    table_headers = []
    table_rows = []
    soup = BeautifulSoup(html_table, "html.parser")

    for table_row in soup.select('tr'):
        headers = table_row.find_all('th')
        cells = table_row.find_all('td')

        if headers:
            table_headers.append([header.text.strip() for header in headers])

        if len(cells) > 0:
            cell_values = []

            for cell in cells:
                cell_values.append(cell.text.strip())

            table_rows.append(cell_values)

    return Table(headers=table_headers, rows=table_rows)
