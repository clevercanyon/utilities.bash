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
import { $fs } from '../../../node_modules/@clevercanyon/utilities.node/dist/index.js';
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
        arrowParens: 'always',
        bracketSameLine: false,
        bracketSpacing: true,
        embeddedLanguageFormatting: 'auto',
        endOfLine: 'lf',
        htmlWhitespaceSensitivity: 'css',
        insertPragma: false,
        jsxSingleQuote: true,
        printWidth: 180,
        proseWrap: 'preserve',
        quoteProps: 'preserve',
        requirePragma: false,
        semi: true,
        singleAttributePerLine: false,
        singleQuote: true,
        tabWidth: 4,
        trailingComma: 'all',
        useTabs: false,
        vueIndentScriptAndStyle: true,
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
                    parser: 'sh', // Posix variant!
                    variant: 1, // Posix variant only.
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
                    parser: 'sh', // Bash variant!
                    variant: 0, // Bash variant only.
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
                    jsdocDescriptionTag: false,
                    jsdocDescriptionWithDot: true,
                    jsdocKeepUnParseAbleExampleIndent: false,
                    jsdocLineWrappingStyle: 'greedy',
                    jsdocPreferCodeFences: false,
                    jsdocPrintWidth: baseConfig.printWidth - 60,
                    jsdocSeparateReturnsFromParam: false,
                    jsdocSeparateTagGroups: true,
                    jsdocSingleLineComment: false,
                    jsdocSpaces: 1,
                    jsdocVerticalAlignment: true,
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
                    tailwindFunctions: tailwindSettings.classFunctions,
                    tailwindAttributes: tailwindSettings.classAttributes,
                    tailwindConfig: path.resolve(projDir, './tailwind.config.mjs'),
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
                    commaPosition: 'after',
                    database: 'mysql',
                    denseOperators: false,
                    expressionWidth: baseConfig.printWidth,
                    formatter: 'sql-formatter',
                    indentStyle: 'standard',
                    keywordCase: 'upper',
                    language: 'sql',
                    linesBetweenQueries: 1,
                    logicalOperatorNewline: 'before',
                    newlineBeforeSemicolon: false,
                    params: Object,
                    paramTypes: Object,
                    tabulateAlias: false,
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
                options: { parser: '' }, // Not ready for production yet, but coming soon.
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
                    keySeparator: '=',
                    escapeNonLatin1: false,
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
                    xmlSelfClosingSpace: true,
                    xmlSortAttributesByKey: false,
                    xmlQuoteAttributes: 'preserve',
                    xmlWhitespaceSensitivity: 'ignore',
                },
            },
        ],
    };
};
