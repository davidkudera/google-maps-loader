import {google} from './types';


export declare interface LoaderOptions
{
	version?: string,
	client?: string,
	channel?: string,
	language?: string,
	region?: string,
	libraries?: Array<string>,
}

export class Loader
{
	private static CALLBACK_NAME = '_dk_google_maps_loader_cb';

	private loader: Promise<google>|undefined;

	private resolve: (api: google) => void;

	private reject: (err: Error) => void;

	private api: google|undefined;

	constructor(
		private apiKey: string = null,
		private options: LoaderOptions = {},
	) {
		if (typeof window === 'undefined') {
			throw new Error('google-maps is supported only in browser environment');
		}
	}

	public load(): Promise<google>
	{
		if (typeof this.api !== 'undefined') {
			return Promise.resolve(this.api);
		}

		if (typeof this.loader !== 'undefined') {
			return this.loader;
		}

		window[Loader.CALLBACK_NAME] = () => {
			this.api = window['google'];

			if (typeof this.resolve === 'undefined') {
				throw new Error('Should not happen');
			}

			this.resolve(this.api);
		};

		window['gm_authFailure'] = () => {
			if (typeof this.reject === 'undefined') {
				throw new Error('Should not happen');
			}

			this.reject(new Error('google-maps: authentication error'));
		};

		return this.loader = new Promise((resolve, reject) => {
			this.resolve = resolve;
			this.reject = reject;

			const script = document.createElement('script');
			script.src = this.createUrl();
			script.async = true;
			script.onerror = (e) => reject(e);

			document.head.appendChild(script);
		});
	}

	private createUrl(): string
	{
		const parameters: Array<string> = [
			`callback=${Loader.CALLBACK_NAME}`,
		];

		if(this.apiKey) {
			parameters.push(`key=${this.apiKey}`);
		}

		for (let name in this.options) {
			if (this.options.hasOwnProperty(name)) {
				let value = this.options[name];

				if (name === 'version') {
					name = 'v';
				}

				if (name === 'libraries') {
					value = value.join(',');
				}

				parameters.push(`${name}=${value}`);
			}
		}

		return `https://maps.googleapis.com/maps/api/js?${parameters.join('&')}`;
	}
}
