function raw = Vehicle_Data_Extractor(egoPose)

out.time = getCurrentTime();
out.lat = egoPose.Latitude;
out.lon = egoPose.Longitude;
out.x = egoPose.Position(1);
out.y = egoPose.Position(2);
out.yaw = egoPose.Yaw;
out.vx

end