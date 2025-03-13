/**
 * Prettier config file.
 *
 * Prettier is not aware of this config file's location.
 *
 * @note PLEASE DO NOT EDIT THIS FILE!
 * @note This entire file will be updated automatically.
 * @note Instead of editing here, please review <https://github.com/clevercanyon/skeleton>.
 *
 * @fastglob Prettier uses fast-glob under the hood, with `{ dot: true }`.
 *
 * @see https://prettier.io/docs/en/configuration.html
 */

import path from 'node:path';
import { sql as sqlDialect } from 'sql-formatter';
import { $fs } from '../../../node_modules/@clevercanyon/utilities.node/dist/index.js';
import { $json } from '../../../node_modules/@clevercanyon/utilities/dist/index.js';
import extensions from '../bin/includes/extensions.mjs';
import tailwindSettings from '../tailwind/settings.mjs';

const __dirname = $fs.imuDirname(import.meta.url);
const projDir = path.resolve(__dirname, '../../..');

/**
 * Defines Prettier configuration.
 */
export default async () => {
    /**
     * Base config.
     */
    const baseConfig = {
        /**
         * Plugins.
         */
        plugins: [
            // Misc. parsers.
            'prettier-plugin-sh',
            'prettier-plugin-ini',
            'prettier-plugin-sql',
            'prettier-plugin-toml',
            '@prettier/plugin-xml',
            '@prettier/plugin-php',
            '@prettier/plugin-ruby',
            'prettier-plugin-properties',

            // In this specific order...
            // See: <https://o5p.me/87sPJC>.
            'prettier-plugin-organize-imports',
            'prettier-plugin-jsdoc', // After organize imports.
            'prettier-plugin-tailwindcss', // Must come last, always.
        ],

        /**
         * Standard options.
         */
        // Pragma options.
        insertPragma: false, // {@see https://prettier.io/docs/en/options#insert-pragma}
        requirePragma: false, // {@see https://prettier.io/docs/en/options#require-pragma}

        // Indentation options.
        tabWidth: 4, // {@see https://prettier.io/docs/en/options#tab-width}.
        useTabs: false, // {@see https://prettier.io/docs/en/options#tabs}

        // Line length and EOL options.
        printWidth: 180, // {@see https://prettier.io/docs/en/options#print-width}
        endOfLine: 'lf', // {@see https://prettier.io/docs/en/options#tabs}

        // Quote-related options.
        singleQuote: true, // {@see https://prettier.io/docs/en/options#quotes}
        jsxSingleQuote: true, // {@see https://prettier.io/docs/en/options#jsx-quotes}
        quoteProps: 'preserve', // {@see https://prettier.io/docs/en/options#quote-props}

        // Misc syntax-related style options.
        semi: true, // {@see https://prettier.io/docs/en/options#semicolons}
        trailingComma: 'all', // {@see https://prettier.io/docs/en/options#trailing-commas}
        bracketSpacing: true, // {@see https://prettier.io/docs/en/options#bracket-spacing}
        arrowParens: 'always', // {@see https://prettier.io/docs/en/options#arrow-function-parentheses}.
        objectWrap: 'preserve', // {@see https://prettier.io/docs/options#object-wrap}.
        experimentalTernaries: false, // {@see https://prettier.io/docs/en/options#experimental-ternaries}.
        experimentalOperatorPosition: 'end', // {@see https://prettier.io/docs/options#experimental-operator-position}.

        // Markdown, HTML, JSX related options.
        proseWrap: 'preserve', // {@see https://prettier.io/docs/en/options#prose-wrap}
        bracketSameLine: false, // {@see https://prettier.io/docs/en/options#bracket-line}
        singleAttributePerLine: false, // {@see https://prettier.io/docs/en/options#single-attribute-per-line}
        htmlWhitespaceSensitivity: 'css', // {@see https://prettier.io/docs/en/options#html-whitespace-sensitivity}
        vueIndentScriptAndStyle: true, // {@see https://prettier.io/docs/en/options#vue-files-script-and-style-tags-indentation}

        // Embedded language formatting options.
        embeddedLanguageFormatting: 'auto', // {@see https://prettier.io/docs/en/options#embedded-language-formatting}.
    };

    /**
     * Composition.
     */
    return {
        ...baseConfig,

        overrides: [
            /**
             * Documents.
             */

            {
                /**
                 * MD parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.markdown])],
                options: { parser: 'markdown' },
            },
            {
                /**
                 * MDX parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.mdx])],
                options: { parser: 'mdx' },
            },
            {
                /**
                 * HTML parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byCanonical.html, ...extensions.byCanonical.shtml])],
                options: { parser: 'html' },
            },

            /**
             * Backend code.
             */

            {
                /**
                 * PHP plugin options.
                 *
                 * @see https://o5p.me/BHsZj8
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.php])],
                options: {
                    parser: 'php',
                    braceStyle: '1tbs',
                    phpVersion: '8.1',
                    singleQuote: true,
                    trailingCommaPHP: true,
                },
            },
            {
                /**
                 * Ruby plugin options.
                 *
                 * @see https://o5p.me/tuKNvU
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.ruby])],
                options: {
                    parser: 'ruby',
                    rubyPlugins: '',
                    rubySingleQuote: true,
                },
            },
            {
                /**
                 * Python plugin options.
                 *
                 * @see https://o5p.me/wWDiYK
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.python])],
                options: { parser: '' }, // Work-in-progress. For now, use <https://o5p.me/M18xzK>.
            },
            {
                /**
                 * Sh plugin options.
                 *
                 * @see https://o5p.me/D0rlOV
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byCanonical.sh])],
                options: {
                    parser: 'sh',
                    binaryNextLine: false,
                    experimentalWasm: false,
                    functionNextLine: false,
                    indent: baseConfig.tabWidth,
                    keepComments: true,
                    keepPadding: false,
                    minify: false,
                    spaceRedirects: true,
                    stopAt: undefined,
                    switchCaseIndent: true,
                    variant: 1, // Posix variant.
                },
            },
            {
                /**
                 * Bash plugin options.
                 *
                 * @see https://o5p.me/D0rlOV
                 */
                files: [
                    '*.' + extensions.asBracedGlob([...extensions.byCanonical.bash]), //
                    '{,*.}Dockerfile', // Safe to assume ours always uses bash.
                ],
                options: {
                    parser: 'sh',
                    binaryNextLine: false,
                    experimentalWasm: false,
                    functionNextLine: false,
                    indent: baseConfig.tabWidth,
                    keepComments: true,
                    keepPadding: false,
                    minify: false,
                    spaceRedirects: true,
                    stopAt: undefined,
                    switchCaseIndent: true,
                    variant: 0, // Bash variant.
                },
            },

            /**
             * Frontend code (most of the time).
             */

            {
                /**
                 * JavaScript parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byDevGroup.allJavaScript])],
                options: { parser: 'babel' },
            },
            {
                /**
                 * TypeScript parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byDevGroup.allTypeScript])],
                options: { parser: 'typescript' },
            },
            {
                /**
                 * JSDoc plugin options.
                 *
                 * @see https://o5p.me/dTTfse
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byDevGroup.allJavaScript, ...extensions.byDevGroup.allTypeScript])],
                options: {
                    jsdocAddDefaultToDescription: false,
                    jsdocCapitalizeDescription: true,
                    jsdocCommentLineStrategy: 'keep',
                    jsdocDescriptionTag: false,
                    jsdocDescriptionWithDot: true,
                    jsdocKeepUnParseAbleExampleIndent: false,
                    jsdocLineWrappingStyle: 'greedy',
                    jsdocPreferCodeFences: false,
                    jsdocPrintWidth: baseConfig.printWidth - 60,
                    jsdocSeparateReturnsFromParam: false,
                    jsdocSeparateTagGroups: true,
                    jsdocSpaces: 1,
                    jsdocVerticalAlignment: true,
                    jsdocTagsOrder: undefined,
                    tsdoc: false,
                },
            },
            {
                /**
                 * Organize import plugin options.
                 *
                 * @see https://o5p.me/o7OmDG
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byDevGroup.allJavaScript, ...extensions.byDevGroup.allTypeScript])],
                options: {
                    organizeImportsSkipDestructiveCodeActions: true,
                },
            },
            {
                /**
                 * Tailwind plugin options.
                 *
                 * @see https://o5p.me/RleCLk
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.tailwindPrettierContent])],
                options: {
                    tailwindPreserveDuplicates: false,
                    tailwindPreserveWhitespace: false,
                    tailwindFunctions: tailwindSettings.classFunctions,
                    tailwindAttributes: tailwindSettings.classAttributes,

                    tailwindConfig: path.resolve(projDir, './tailwind.config.mjs'),
                    // As of 2025-03-13, Tailwind v4 is indeed supported by this plugin.
                    // Therefore, we could also set a v4 CSS entry, in addition to a v3 config.

                    // ...(fs.existsSync(path.resolve(srcDir, './index.css')) //
                    //   ? { tailwindStylesheet: path.resolve(srcDir, './index.css') }
                    //    : {}), // It would be nice if this supported globs.
                },
            },
            {
                /**
                 * CSS parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.css])],
                options: { parser: 'css' },
            },
            {
                /**
                 * SCSS parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.scss])],
                options: { parser: 'scss' },
            },
            {
                /**
                 * Less parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.less])],
                options: { parser: 'less' },
            },

            /**
             * Data/config files.
             */

            {
                /**
                 * SQL plugin options.
                 *
                 * @see https://o5p.me/kYq5bx
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.sql])],
                options: {
                    parser: 'sql',
                    database: 'mysql',
                    dataTypeCase: 'upper',
                    denseOperators: false,
                    dialect: $json.stringify(sqlDialect),
                    expressionWidth: baseConfig.printWidth,
                    formatter: 'sql-formatter',
                    functionCase: 'upper',
                    identifierCase: 'preserve',
                    indentStyle: 'standard',
                    keywordCase: 'upper',
                    language: 'sql',
                    linesBetweenQueries: 1,
                    logicalOperatorNewline: 'before',
                    newlineBeforeSemicolon: false,
                    params: $json.stringify({}),
                    paramTypes: $json.stringify({}),
                    type: 'table',
                },
            },
            {
                /**
                 * JSON parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.json])],
                options: { parser: 'json' },
            },
            {
                /**
                 * JSON5 parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.jsonc])],
                options: { parser: 'json5' },
            },
            {
                /**
                 * TOML parser.
                 *
                 * @see https://o5p.me/GI5Eiw
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.toml])],
                options: { parser: 'toml' },
            },
            {
                /**
                 * Yaml parser.
                 *
                 * @see https://o5p.me/sj8jjz
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.yaml])],
                options: { parser: 'yaml' },
            },
            {
                /**
                 * INI plugin options.
                 *
                 * @see https://o5p.me/1fqazf
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.ini])],
                options: {
                    parser: 'ini',
                    iniSpaceAroundEquals: true,
                },
            },
            {
                /**
                 * Properties plugin options.
                 *
                 * @see https://o5p.me/IyzRSp
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.properties]), '*.env{,.*}'],
                options: {
                    parser: 'dot-properties',
                    escapeNonLatin1: false,
                    keySeparator: '=',
                },
            },
            {
                /**
                 * XML plugin options.
                 *
                 * @see https://o5p.me/OiLPzn
                 */
                files: ['*.' + extensions.asBracedGlob([...extensions.byVSCodeLang.xml])],
                options: {
                    parser: 'xml',
                    xmlQuoteAttributes: 'preserve',
                    xmlSelfClosingSpace: true,
                    xmlSortAttributesByKey: false,
                    xmlWhitespaceSensitivity: 'ignore',
                },
            },
        ],
    };
};
