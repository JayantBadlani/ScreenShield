import {NativeModules} from 'react-native';

const {ScreenShieldRN} = NativeModules;

const protectScreenRecording = () => {
  ScreenShieldRN.protectScreenRecording();
};
export default protectScreenRecording;
