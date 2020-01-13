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

	private loader: Promise<any>|undefined;

	private resolve: (value: any) => void;

	private api: any|undefined;

	constructor(
		private apiKey: string,
		private options: LoaderOptions = {},
	) {
		if (typeof window === 'undefined') {
			throw new Error('google-maps-loader is supported only in browser environment');
		}
	}

	public load(): Promise<any>
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

		return this.loader = new Promise((resolve) => {
			this.resolve = resolve;
			const script = document.createElement('script');
			script.src = this.createUrl();
			script.async = true;
			document.head.append(script);
		});
	}

	private createUrl(): string
	{
		const parameters: Array<string> = [
			`key=${this.apiKey}`,
			`callback=${Loader.CALLBACK_NAME}`,
		];

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

		return `//maps.googleapis.com/maps/api/js?${parameters.join('&')}`;
	}
}
