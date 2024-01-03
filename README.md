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

The robot uses the `beautifulsoup4` and `robocorp` dependencies in the `conda.yaml` configuration file.

> [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) is a Python library for pulling data out of HTML and XML files. It works with your favorite parser to provide idiomatic ways of navigating, searching, and modifying the parse tree. It commonly saves programmers hours or days of work.

> We use a python dataclass to store the table data, for more complex examples use [Pandas](https://pypi.org/project/pandas/).

## The HTML table custom parser library

> HTML tables come in many shapes and forms. This example uses a well-formatted and straightforward table. More complex tables might require more effort to parse. Still, the idea is the same: Read and parse the HTML. Return a generic data structure that is easy to work with.

The `get_html_table` function returns the example HTML table markup from https://www.w3schools.com/html/html_tables.asp.

The `read_table_from_html` is provided by the `html_tables.py` library. It parses and returns the given HTML table as a `Table` structure.
