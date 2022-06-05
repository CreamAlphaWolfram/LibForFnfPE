--Cream Alpha Wolfram's FNF Psych Engine function library v1.2
--Credit to NinjaMuffin99 for making Friday Night Funkin'
--Credit to ShadowMario for making FNF': Psych Engine

function onCreate()
	healthset.si = 1 --start health for hpSmoothTween(duration, target) function
	healthset.ei = 1 --end health for hpSmoothTween(duration, target) function
	healthset.et = 1 --elapsed time for hpSmoothTween(duration, target) function
	healthset.ft = 0 --fin time for hpSmoothTween(duration, target) function
	healthset.way = 0 --way for hpSmoothTween(duration, target) function
end

function doTweenScale(tag, variable, value, duration, ease) --just.. exactly
    if duration <= 0 then --yeah sanity check
        scaleObject(variable,value,value)
    else
        doTweenX(tag..'X',variable..'.scale',value,duration,ease)
        doTweenY(tag..'Y',variable..'.scale',value,duration,ease)
    end
end

function setHealth(way, points) --'points' should be no less than -2
    if way == 'addition' then
        setProperty('health', getProperty('health')+points)
    elseif way == 'direct' then
        setProperty('health', points)
    elseif way == 'noDyingAddition' then
        if getProperty('health') + points < 0.001 then
            setProperty('health', 0.001) --lol
        else
            setProperty('health', getProperty('health')+points)
        end
    end
end

function cameraAction(action, camera, colorOrIntensity, duration, forced) --yup
    if action == 'shake' then
        cameraShake(camera, colorOrIntensity, duration)
    elseif action == 'flash' then
        cameraFlash(camera, colorOrIntensity, duration, forced)
    elseif action == 'fade' then
        cameraFade(camera, colorOrIntensity, duration, forced)
    end
end

function printText(t1,t2,t3,t4,t5) --just exactly copied
    debugPrint(t1, t2, t3, t4, t5)
end

function hpSmoothTween(duration, target)
    if duration > 0 then
        healthset.ft = duration * 60;  --
        healthset.way = 2;
    end
    if duration == 0 then
        setProperty('health', target); --immediately
        healthset.way = 0;
    end
    if duration < 0 then
        healthset.ft = -(duration) * 60;
        healthset.way = 1;
    end
    healthset.si = getProperty('health');
    healthset.ei = target;
    healthset.et = 0;
end

function onUpdate(elapsed)
    -- part 1 of the block - start --
	healthset.et = healthset.et + 1;
	if healthset.et > healthset.ft then
		healthset.way = 0;
	end
	if healthset.way == 1 then
		setProperty('health', healthset.si+(healthset.ei-healthset.si)*(healthset.et/healthset.ft));
	elseif healthset.way == 2 then
		setProperty('health', healthset.si+(healthset.ei-healthset.si)*(1-(1+math.cos(3.141592653589793*(healthset.et/healthset.ft)))/2));
	end --ayo that's so long
    -- part 1 of the block - end --
end

function onTweenCompleted(tag)
    printText('tween '..tag..' completed')
end