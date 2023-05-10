# IOSVaporHTTPServer
Did you try install a certificate or something else from your iOS app? 
This repository contains a simple example of an iOS app with a embedded Vapor server + Leaf page where you stamps your certificates for invoke the utomatic installation of Safari.

## Usage
Put your cert file in documents directory (from DerivedData) and start the app.

## Security
I have implemented two security systems.
```
- Deploy in a dynamic random port (considering reserved ports).
- Deploy in a random path. The certificate will launched each server run in a randomized path.
- Autostop server (after a seconds editable in config)
```

This would be enough for avoid "thing in the middle"... 
