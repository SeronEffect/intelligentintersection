function h = udp_cam_sender(ip, port, stationID, geoRefLatLon)
% Create a CAM type message UDP sender
% 
% function returns a handle struct method to be called
% inside scenario loop to send data on every simulation step
% 
%
% ETSI requirements towards scales and ranges:
% - Latitude    :
% - Longitude   :
% - Heading     :
% - Speed       :
% - StationID   :
% TODO: check references
% EN 302 637-2 Annex A CAM ASN.1 and CDD TS 102 894-2
% towards data scales and "unavailable" code
%
% Call pattern:
%       cam = udp_cam_sender('127.0.0.1', 8000, uint32(1),
%       scenario.GeoReference(1:2));
%       ...
%       while running
%           cam.send(scenario, egoVehicle);
%       end

udp = udpport("byte");
h.ip = ip;
h.port = port;
h.udp = udp;

% geo reference for WGS84 conversion
if nargin < 4 || isempty(geoRefLatLon)
    error("GeoReference not provided as [lat0 lon0].");
end

h.lat0 = geoRefLatLon(1);
h.lon0 = geoRefLatLon(2);
% h.lonScale = 111319.49079327357 * cos(h.lat0);    % meters per degree
% h.latScale = 111319.49079327357;

% header section
h.protocolVersion = uint8(1);
h.messageID = uint8(2); % CAM
h.stationID = uint32(stationID);

% sender method exposure
h.send = @(scenario, egoVeh) doSend(h, scenario, egoVeh);
end


% ===================================
function doSend(h, scenario, egoVeh)

pose = actorPoses(senario);
egoID = egoVeh.ActorID;
ego = pose([pose.ActorID] == egoID);
