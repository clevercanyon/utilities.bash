/**
 * Vite config file.
 *
 * Vite is aware of this config file's location.
 *
 * @note CUSTOM EDITS ONLY PLEASE!
 * @note In the future this file will be updated automatically.
 * @note Only `<custom:start.../custom:end>` will be preserved below.
 */
/* eslint-env es2021, node */

import defineConfig from './dev/.files/vite/config.js';

/*
 * Customizations
 * <custom:start> */

export default async (vite) => {
	return await defineConfig(vite, {});
};

/* </custom:end> */
