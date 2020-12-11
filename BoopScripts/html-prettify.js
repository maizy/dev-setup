/**
{
  "api": 1,
  "name": "HTML Prettify",
  "description": "",
  "author": "Nikita Kovalev",
  "icon": "HTML",
  "tags": "html"
}
**/

// ---
// https://www.npmjs.com/package/html-prettify/v/1.0.3
// MIT License
/**
 * @function addIndentation
 * @description Adds 2 spaces indentation
 *
 * @param {string[]} splittedHtml
 * @returns {string} Formatted html markup string with 2 spaces indentation
 */
const addIndentation = splittedHtml => {
  let level = 0;
  const opened = [];

  return splittedHtml.reverse().reduce((indented, elTag) => {
    if (opened.length
      && level
      && opened[level]
      /* if current element tag is the same as previously opened one */
      && opened[level] === elTag.substring(1, opened[level].length + 1)
    ) {
      opened.splice(level, 1);
      level--;
    }

    const indentation = ' '.repeat(level ? level * 2 : 0);

    const newIndented = [
      `${indentation}${elTag}`,
      ...indented,
    ];

    // if current element tag is closing tag
    // add it to opened elements
    if (elTag.substring(0, 2) === '</') {
      level++;
      opened[level] = elTag.substring(2, elTag.length - 1);
    }

    return newIndented;
  }, []).join('\n');
};

const removeEmptyLines = nonFormattedString => (
  nonFormattedString
    .trim()
    .split('\n')
    .reduce((nonempty, line) => {
      const trimmedLine = line.trim();
      return trimmedLine.length ? [...nonempty, trimmedLine] : nonempty;
    }, [])
);

const toLines = markup => {
  let opened = '';

  const nonemptyLines = removeEmptyLines(markup);

  return nonemptyLines.reduce((formatted, line, i, prevArr) => {
    if (line.startsWith('<')) {
      if (i === prevArr.length - 1) {
        return [...formatted, opened, line];
      }

      const closedLine = opened;
      opened = line;

      if (closedLine.length) {
        return [...formatted, closedLine];
      }

      return formatted;
    }

    // append current line to previous line
    opened += line === '>' ? line : ` ${line}`;

    return formatted;
  }, []);
};

const prettify = markup => {
  const splitted = toLines(markup);

  return addIndentation(splitted);
};
// --


function main(input) {
  input.text = prettify(input.text);
}
