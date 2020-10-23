//
//  AudioSystemProvider.swift
//  OSXSoundManager
//
//  Created by Louis Dumont on 23/10/2020.
//

import Cocoa
import CoreAudio

class AudioSystemProvider {
    private var defaultDeviceId: AudioDeviceID = kAudioObjectUnknown;
    /**
        Obtain default audio device ID
     */
    private func obtainDefaultOutputDeviceID() -> AudioDeviceID {
        var result: AudioDeviceID = kAudioObjectUnknown;
        var audioDeviceIDSize : UInt32 = UInt32(MemoryLayout<AudioDeviceID>.size);
        var defaultAudioObjectAddress:AudioObjectPropertyAddress = AudioObjectPropertyAddress();
        
        defaultAudioObjectAddress.mSelector = kAudioHardwarePropertyDefaultOutputDevice;
        defaultAudioObjectAddress.mScope = kAudioObjectPropertyScopeGlobal;
        defaultAudioObjectAddress.mElement = kAudioObjectPropertyElementMaster;
        
        if (!AudioObjectHasProperty(AudioObjectID(kAudioObjectSystemObject),&defaultAudioObjectAddress) )    {
                NSLog("Unable to get default audio device");
                return result;
            }
        
        //get the property 'default output device'
        let  error: OSStatus = AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &defaultAudioObjectAddress, 0, nil, &audioDeviceIDSize, &result);
            if (error != noErr) {
                NSLog("Unable to get output audio device");
                return result;
            }
        
        return result;
    }
    /**
        Public function to retrieve default audio device ID
     */
    public func getDefaultAudioOutputDeviceId() -> AudioDeviceID {
        if(defaultDeviceId == kAudioObjectUnknown){
            self.defaultDeviceId = self.obtainDefaultOutputDeviceID();
        }
        
        return self.defaultDeviceId;
    }
    
    /**
        Get if volume is muted for deviceId passed as arguments
     */
    public func isVolumeMuted(deviceId: AudioDeviceID) -> Bool {
        var audioDeviceObjectAddress: AudioObjectPropertyAddress = AudioObjectPropertyAddress();
        var hasMute: Bool;
        var canMute: DarwinBoolean = DarwinBoolean.init(false);
        var isMuted: UInt32 = 0;
        var error:OSStatus = noErr;
        var mutedSize: UInt32 = 4;
        
        audioDeviceObjectAddress.mElement = kAudioObjectPropertyElementMaster;
        audioDeviceObjectAddress.mScope = kAudioDevicePropertyScopeOutput;
        audioDeviceObjectAddress.mSelector = kAudioDevicePropertyMute;
        hasMute = AudioObjectHasProperty(deviceId, &audioDeviceObjectAddress);
        
        if(hasMute){
            error = AudioObjectIsPropertySettable(deviceId, &audioDeviceObjectAddress, &canMute);
            if(error == noErr && canMute.boolValue){
                AudioObjectGetPropertyData(deviceId, &audioDeviceObjectAddress, 0, nil, &mutedSize, &isMuted);
                if((isMuted) != 0){
                    return true;
                }
            }
        }
        return false;
    }
}
