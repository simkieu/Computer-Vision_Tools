function IN = imnormalize(I)
I = I - min(min(I));
IN = I/max(max(I));
end