function y = saturate(u, lower, upper)
%SATURATE Clamp a signal between lower and upper bounds.

y = min(max(u, lower), upper);
end
