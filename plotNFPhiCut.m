function [] = plotNFPhiCut(data_nf2ff,phi_cut,normalized,logarithmic)


% Find values in cutting plane
i = find(data_nf2ff.phi==phi_cut);

% Flip one have of the values to make continous plot
nf2ff_cut_angles = data_nf2ff.theta(i)';
maxValue = max(max(data_nf2ff.Eabs(i)));
if normalized == true
    nf2ff_cut =  data_nf2ff.Eabs(i)/maxValue;
else
    nf2ff_cut =  data_nf2ff.Eabs(i);
end

if logarithmic == true
    plot(nf2ff_cut_angles*180/pi,20*log10(nf2ff_cut))
elseif logarithmic == false
    plot(nf2ff_cut_angles*180/pi,nf2ff_cut)
end
hold on
end


