/**
 * Extensions.
 *
 * @note PLEASE DO NOT EDIT THIS FILE!
 * @note This entire file will be updated automatically.
 * @note Instead of editing here, please review <https://github.com/clevercanyon/skeleton>.
 */

import { $obj, $path } from '../../../../node_modules/@clevercanyon/utilities/dist/index.js';

/**
 * Adds leading dot to extensions.
 *
 * @param   exts Array of extensions.
 *
 * @returns      Array of extensions (with dot).
 */
const dot = (exts) => noDot(exts).map((ext) => '.' + ext);

/**
 * Strips leading dot from extensions.
 *
 * @param   exts Array of extensions.
 *
 * @returns      Array of extensions (not dot).
 */
const noDot = (exts) => [...new Set(exts)].map((ext) => ext.replace(/^\./u, ''));

/**
 * Converts an array of extensions into a braced glob.
 *
 * @param   exts Array of extensions.
 *
 * @returns      Extensions as a braced glob.
 *
 * @note Don’t use `{}` braces in TypeScript config files; i.e., incompatible.
 */
const asBracedGlob = (exts) => {
    exts = [...new Set(exts)]; // Unique.
    return (exts.length > 1 ? '{' : '') + noDot(exts).join(',') + (exts.length > 1 ? '}' : '');
};

/**
 * Converts an array of extensions into a regular expression fragment.
 *
 * @param   exts Array of extensions.
 *
 * @returns      Extensions as a regular expression fragment.
 */
const asRegExpFrag = (exts) => {
    exts = [...new Set(exts)]; // Unique.
    return (exts.length > 1 ? '(?:' : '') + noDot(exts).join('|') + (exts.length > 1 ? ')' : '');
};

/**
 * Defines extensions.
 */
const extensions = {
    dot,
    noDot,
    asBracedGlob,
    asRegExpFrag,

    /**
     * MIME type extensions by VS Code language. VS Code languages added to the default export here. Provided by
     * `@clevercanyon/utilities`. This includes everything we have in our MIME types library.
     */
    ...$obj.map($path.extsByVSCodeLang(), (exts) => dot(exts)),

    // True HTML/SHTML.

    trueHTML: ['.htm', '.html'],
    trueSHTML: ['.shtm', '.shtml'],

    // Standard JS/TS.

    sJavaScript: ['.js'],
    sJavaScriptReact: ['.jsx'],

    sTypeScript: ['.ts'],
    sTypeScriptReact: ['.tsx'],

    // Common JS/TS.

    cJavaScript: ['.cjs'],
    cJavaScriptReact: ['.cjsx'],

    cTypeScript: ['.cts'],
    cTypeScriptReact: ['.ctsx'],

    // Module JS/TS.

    mJavaScript: ['.mjs'],
    mJavaScriptReact: ['.mjsx'],

    mTypeScript: ['.mts'],
    mTypeScriptReact: ['.mtsx'],

    // All flavors of JSX/TSX.

    allJavaScriptReact: ['.jsx', '.cjsx', '.mjsx'],
    allTypeScriptReact: ['.tsx', '.ctsx', '.mtsx'],

    // All flavors of JS/TS.

    allJavaScript: ['.js', '.jsx', '.cjs', '.cjsx', '.mjs', '.mjsx'],
    allTypeScript: ['.ts', '.tsx', '.cts', '.ctsx', '.mts', '.mtsx'],
};

/**
 * Content (tailwind).
 */
extensions.tailwindContent = [
    ...new Set([
        ...extensions.mdx,
        ...extensions.markdown,

        ...extensions.xml,
        ...extensions.html,
        ...extensions.trueHTML,
        ...extensions.trueSHTML,

        ...extensions.php,
        ...extensions.ruby,
        ...extensions.perl,
        ...extensions.python,
        ...extensions.shellscript,

        ...extensions.allJavaScript,
        ...extensions.allTypeScript,
    ]),
];
extensions.tailwindPrettierContent = [...extensions.tailwindContent];

/**
 * Content (comment anchors).
 */
extensions.commentAnchorsContent = [...extensions.tailwindContent];

/**
 * Extensions to try on import w/o extension.
 */
extensions.onImportWithNoExtensionTry = [...extensions.allTypeScript, ...extensions.allJavaScript];

/**
 * Default export.
 */
export default extensions;
