/**
 * `$ madrun` config file.
 *
 * `$ madrun` is aware of this config file's location.
 *
 * @note CUSTOM EDITS ONLY PLEASE!
 * @note In the future this file will be updated automatically.
 * @note Only `<custom:start.../custom:end>` will be preserved below.
 */

import baseConfig from './dev/.files/configs/madrun/config.mjs';
import { $obj } from './node_modules/@clevercanyon/utilities/dist/index.js';

/*
 * Customizations.
 * <custom:start> */

export default async (context) => {
    return $obj.mergeDeep({}, await baseConfig(context), {
        // 'project:[cmd]': '', // Always prefix project CMDs.
    });
};

/* </custom:end> */
