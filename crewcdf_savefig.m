function [] = crewcdf_savefig(f, name, types)
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
% See also: CREWCDF_IMAGESC, CREWCDF_PLOTPERS
%
% Mikolaj Chwalisz <chwaliszATtkn.tu-berlin.de>

if ~exist('types','var')
    types = {'fig','png','pdf'};
end

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
if any(strcmp(types,'pdf'))
    try
        print(f, [name '.pdf'], '-dpdf')
    catch ME
        disp(ME)
    end
end
if any(strcmp(types,'fig'))
    try
        saveas(f, [name '.fig'],'fig')
    catch ME
        disp(ME)
    end
end
set(f, 'PaperOrientation','Portrait');
if (length(findall(gcf,'type','axes')) - length(findall(gcf,'tag','Colorbar'))) >= 2
    % figure contains subplot, print as square
    set(gcf,'PaperUnits','centimeters','PaperSize',[21,21],'PaperPosition',[0 0 21 21])
else
    % no subplot, print as horizontal A4
    set(gcf,'PaperUnits','centimeters','PaperSize',[29.7, 21],'PaperPosition',[0 0 29.7, 21])
end
if any(strcmp(types,'png'))
    print(f, [name '.png'], '-r500', '-dpng')
end
end
