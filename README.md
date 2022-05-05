# Working with HTML tables

This robot demonstrates how to work with HTML tables.

## The example HTML table

We use the table at https://www.w3schools.com/html/html_tables.asp as an example:

```html
<table id="customers">
  <tbody>
    <tr>
      <th>Company</th>
      <th>Contact</th>
      <th>Country</th>
    </tr>
    <tr>
      <td>Alfreds Futterkiste</td>
      <td>Maria Anders</td>
      <td>Germany</td>
    </tr>
    <tr>
      <td>Centro comercial Moctezuma</td>
      <td>Francisco Chang</td>
      <td>Mexico</td>
    </tr>
    <tr>
      <td>Ernst Handel</td>
      <td>Roland Mendel</td>
      <td>Austria</td>
    </tr>
    <tr>
      <td>Island Trading</td>
      <td>Helen Bennett</td>
      <td>UK</td>
    </tr>
    <tr>
      <td>Laughing Bacchus Winecellars</td>
      <td>Yoshi Tannamuri</td>
      <td>Canada</td>
    </tr>
    <tr>
      <td>Magazzini Alimentari Riuniti</td>
      <td>Giovanni Rovelli</td>
      <td>Italy</td>
    </tr>
  </tbody>
</table>
```

## The HTML parser library: Beautiful Soup

The robot uses the `beautifulsoup4` and the `rpaframework` dependencies in the `conda.yaml` configuration file:

```yaml
channels:
  - conda-forge

dependencies:
  - python=3.7.5
  - beautifulsoup4=4.11.1
  - pip=20.1
  - pip:
      - rpaframework==14.0.0
```

> [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) is a Python library for pulling data out of HTML and XML files. It works with your favorite parser to provide idiomatic ways of navigating, searching, and modifying the parse tree. It commonly saves programmers hours or days of work.

> [RPA.Tables](https://robocorp.com/docs/libraries/rpa-framework/rpa-tables) is great for manipulating, sorting, and filtering tabular data. Common use-cases are reading and writing CSV files, inspecting files in directories, or running tasks using existing Excel data.

## The HTML table custom parser library

The robot includes a custom HTML parser that uses Beautiful Soup internally. Beautiful Soup is mighty and flexible. Building your customized parsers does not take too long!

> HTML tables come in many shapes and forms. This example uses a well-formatted and straightforward table. More complex tables might require more effort to parse. Still, the idea is the same: Read and parse the HTML. Return a generic data structure that is easy to work with.

`html_tables.py`:

```py
from bs4 import BeautifulSoup
from RPA.Tables import Table


def read_table_from_html(html_table: str) -> Table:
    """Parses and returns the given HTML table as a Table structure.

    :param html_table: Table HTML markup.
    """
    table_rows = []
    soup = BeautifulSoup(html_table, "html.parser")

    for table_row in soup.select('tr'):
        cells = table_row.find_all('td')

        if len(cells) > 0:
            cell_values = []

            for cell in cells:
                cell_values.append(cell.text.strip())

            table_rows.append(cell_values)

    return Table(table_rows)

```

## The robot

```robot
*** Settings ***
Documentation       Working with HTML tables.

Library             html_tables.py
Library             RPA.Browser.Selenium
Library             RPA.Tables

Task Teardown       Close All Browsers


*** Tasks ***
Read HTML table as Table
    ${html_table}=    Get HTML table
    ${table}=    Read Table From Html    ${html_table}
    ${dimensions}=    Get Table Dimensions    ${table}
    ${first_row}=    Get Table Row    ${table}    ${0}
    ${first_cell}=    RPA.Tables.Get Table Cell    ${table}    ${0}    ${0}
    FOR    ${row}    IN    @{table}
        Log To Console    ${row}
    END


*** Keywords ***
Get HTML table
    Open Available Browser
    ...    https://www.w3schools.com/html/html_tables.asp
    ...    headless=True
    ${html_table}=    Get Element Attribute    css:table#customers    outerHTML
    RETURN    ${html_table}
```

The `Get HTML table` keyword returns the example HTML table markup from https://www.w3schools.com/html/html_tables.asp.

The `Read Table From Html` is provided by the `html_tables.py` library. It parses and returns the given HTML table as a `Table` structure.

The returned data structure can be worked with all the keywords in the [RPA.Tables](https://robocorp.com/docs/libraries/rpa-framework/rpa-tables) library.
