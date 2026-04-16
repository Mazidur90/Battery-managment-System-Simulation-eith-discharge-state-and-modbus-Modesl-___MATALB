function profile = defaultDriveCycle(timeline, cfg)
%DEFAULTDRIVECYCLE NEDC-like discharge profile used in the tutorial flow.

rawCurrentA = zeros(size(timeline));

rawCurrentA(timeline >= 40 & timeline < 160) = 18;
rawCurrentA(timeline >= 160 & timeline < 280) = 35;
rawCurrentA(timeline >= 280 & timeline < 430) = 62;
rawCurrentA(timeline >= 430 & timeline < 610) = 80;
rawCurrentA(timeline >= 610 & timeline < 760) = 52;
rawCurrentA(timeline >= 760 & timeline < 900) = 95;
rawCurrentA(timeline >= 900 & timeline < 1040) = 70;
rawCurrentA(timeline >= 1040 & timeline < 1120) = 120;
rawCurrentA(timeline >= 1120 & timeline <= timeline(end)) = 48;

profile.rawCurrentA = rawCurrentA;
profile.currentA = max(rawCurrentA, 0);
profile.ambientTempC = cfg.thermal.ambientTempC + 2.5 * sin(timeline / 350);
end
