import {TurboModule, TurboModuleRegistry} from 'react-native';

export interface Spec extends TurboModule {
  readonly getConstants: () => {};

  // your module methods go here, for example:
  process(id: number): Promise<string>;
}

export default TurboModuleRegistry.get<Spec>('AttachmentProcessor');
