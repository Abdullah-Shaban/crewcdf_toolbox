function [] = crewcdf_savefig(f,name)
%CREWCDF_SAVEFIG Save figure f to fig,pdf,png under 'name'
%
% crewcdf_savefig(f,name)
%
% This will try to save figure 'f' in the all three formats. If it fails it
% will print error message but not fail execution.
%
% It will print the figure in full page horizontal A4 format to increase quality.
%
% Examples:
% crewcdf_savefig(gcf,'nice_figure')
%
% See also:
% CREWCDF_IMAGESC
% CREWCDF_HEATMAP
%
% Mikolaj Chwalisz <chwaliszATtkn.tu-berlin.de>

set(f,...
    'PaperType','A4',...
    'PaperOrientation','landscape', ...
    'PaperPositionMode', 'manual', ...
    'PaperUnits', 'centimeters', ...
    'PaperPosition', [-1 -1 30 21+1] ...
    );
set(f, 'renderer', 'painters');
fax = get(gcf,'CurrentAxes');
set(fax, 'LooseInset', get(fax,'TightInset'))
try
    print(f, [name '.pdf'], '-dpdf')
catch ME
    disp(ME)
end
try
    saveas(f, [name '.fig'],'fig')
catch ME
    disp(ME)
end
set(f, 'PaperOrientation','Portrait');
% set(f, 'PaperPositionMode', 'manual');
% set(f, 'PaperPosition', [0 0 30 21]);
%     'PaperPosition', [-2 -1 30 21+1] ...
%     );
% set(fax, 'Position', get(fax, 'OuterPosition') - ...
%     get(fax, 'TightInset') * [-1 0 1 0; 0 -1 0 1; 0 0 1 0; 0 0 0 1]);
print(f, [name '.png'], '-dpng')
end