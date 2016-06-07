%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coordinate Systems of Euclidean space
%
%%% 1 & 2 Cartesian coordinate system
% System that we are accustom to, that is (x, y), (x, y, z), ...
% such that,
% x == r * cos(theta)
% y == r * sin(theta)
% z == Z
%
%%% 1 & 2 Polar -> Cylindrical -> Spherical coordinate systems:
%       (r, theta) -> (r, theta, Z) -> (not covered)
% such that,
% r == sqrt(x^2 + y^2)
% theta == atan(y/x)
% Z == z
%
%%% 3 & 4. Complex == Gauss plane (all Euclidean spaces),
% kind of Cartesian coordinate system (x, y == real, i == imaginary),
% such that,
% x == r * cos(theta)
% y == r * sin(theta)
%
%%% 3 & 4. Complex Polar -> Cylindrical -> Spherical coordinate systems:
%                (r, theta) -> (invalid in 2D) -> (invalid in 2D)
% such that,
% r == sqrt(x^2 + y^2)
% theta == atan(y/x)
% Tip: Euler's formula, exp(theta*i) == cos(theta) + sin(theta)*i
%
%%% 5. Vector == Subject == Factor space (all Euclidean spaces),
% kind of Cartesian coordinate system where factors are axes,
% such that,
% every point is respresent by (ob1, ob2, ob3, ...).
%
%                                                  Written by Kim, Wiback,
%                                                     2016.05.26. Ver.1.1.
%                                                     2016.05.27. Ver.1.2.
%                                                     2016.05.30. Ver.1.3.
%                                                     2016.06.04. Ver.1.4.
%                                                     2016.06.05. Ver.1.5.
%                                                     2016.06.08. Ver.1.6.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function space_and_coordinates





%% Main figure %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% spacing of objects surrounded by upper-most figure:
% horizontal 50, vertical 50
% spacing of inner objects surrounded by the objects:
% horizontal 10, vertical 20



%%%%%%%%%%%%%%%%%%%
% Upper most figure
%%%%%%%%%%%%%%%%%%%
screen_size = get(0, 'screensize');
fg_size = [1200, 700];
S.fg = figure('units', 'pixels', ...
    'position', ...
    [(screen_size(3) - fg_size(1)) / 2, ... % 1/2*(Screen's x - figure's x)
    (screen_size(4) - fg_size(2)) / 2, ... % 1/2*(Screen's y - figure's y)
    fg_size(1), ... % The figure's x
    fg_size(2)], ... % The figure's y
    'menubar', 'none', ...
    'name','Coordinate Systems of Euclidean space', ...
    'numbertitle', 'off', ...
    'resize', 'off');



%%%%%%%%%%%%%%%%%
% Real or complex
%%%%%%%%%%%%%%%%%
S.bg = uibuttongroup('units', 'pix', ...
    'position', [50, 50, 200, 600], ...
    'title', 'Parameters', 'fontsize', 12, ...
    'titleposition', 'centertop');
S.slide_rc = uicontrol('style', 'popupmenu', ...
    'unit', 'pix', ...
    'position', [60, 600, 180, 30], ...
    'fontsize', 12, ...
    'string', {'Real', 'Complex'});
% We can not use global updating function yet, since GUIs are not set 100%.
set(S.slide_rc, 'callback', {@slide_rc_callback, S})





%% Objects of the Real Domain %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function slide_rc_callback(~, ~, varargin)
        S = varargin{1};
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%
        % Button group objects
        %%%%%%%%%%%%%%%%%%%%%%
        if strcmp(S.slide_rc.String{S.slide_rc.Value}, 'Real')
            
            %%% Eraze all the objects of the complex problem.
            try
                if ishandle(S.pb_init_c)
                    delete(S.pb_init_c)
                    S = rmfield(S, 'pb_init_c');
                    delete(S.pb_xy_c)
                    S = rmfield(S, 'pb_xy_c');
                    delete(S.pb_reset_c)
                    S = rmfield(S, 'pb_reset_c');
                    delete(S.ax_data_c)
                    S = rmfield(S, 'ax_data_c');
                    delete(S.ax_vector_c)
                    S = rmfield(S, 'ax_vector_c');
                    delete(S.ax_polar_c)
                    S = rmfield(S, 'ax_polar_c');
                    delete(S.ax_cylindrical_c)
                    S = rmfield(S, 'ax_cylindrical_c');
                    delete(S.et_process_c)
                    S = rmfield(S, 'et_process_c');
                end
                % When nothing to delete, pass.
            catch
            end
            
            %%% Do not allow switching to the same category.
            try
                if ishandle(S.pb_init_r)
                    return
                end
                % When nothing overlaps, pass.
            catch
            end
            
            %%% Initializing button
            S.pb_init_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 550, 180, 30], ...
                'string', 'Initializing', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 3D button: xyz
            S.pb_xyz_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 500, 180, 30], ...
                'string', '3D: x, y, z', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 2D button: xy
            S.pb_xy_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 450, 180, 30], ...
                'string', '2D: x, y', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 2D button: yz
            S.pb_yz_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 400, 180, 30], ...
                'string', '2D: y, z', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 2D button: xz
            S.pb_xz_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 350, 180, 30], ...
                'string', '2D: x, z', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 1D button: x
            S.pb_x_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 300, 180, 30], ...
                'string', '1D: x', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 1D button: y
            S.pb_y_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 250, 180, 30], ...
                'string', '1D: y', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 1D button: z
            S.pb_z_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 200, 180, 30], ...
                'string', '1D: z', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% Reset button
            S.pb_reset_r = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 70, 180, 50], ...
                'string', 'Reset', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.7, 0.7, 0.7]);
            
            
            
            %%%%%%
            % Axes
            %%%%%%
            
            %%% Data plot
            S.ax_data_r = axes('units', 'pixels', ...
                'position', [300, 375, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_data_r, 'Data in Cartesian', 'fontsize', 15)
            
            %%% Vector plot
            S.ax_vector_r = axes('units', 'pixels', ...
                'position', [750, 375, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_vector_r, 'Vector in Cartesian', 'fontsize', 15)
            
            %%% Polar plot
            S.ax_polar_r = polaraxes('units', 'pixels', ...
                'position', [300, 50, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_polar_r, ...
                'Data in Polar', 'fontsize', 15)
            
            %%% Cylindrical plot
            S.ax_cylindrical_r = axes('units', 'pixels', ...
                'position', [750, 50, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_cylindrical_r, ...
                'Data in Cylindrical', 'fontsize', 15)
            
            
            
            %%%%%%%%%%%%%
            % Process bar
            %%%%%%%%%%%%%
            S.et_process_r = uicontrol('style', 'edit', ...
                'units', 'pix', ...
                'position', [595, 660, 260, 30], ...
                'string', 'x(f_1), y(f_2), z(factor_3)', ...
                'fontsize', 20, ...
                'ForegroundColor', 'red', ...
                'backgroundcolor', [1, 1, 1], ...
                'horizontalalign', 'center', ...
                'fontweight', 'bold');
            
            
            
            
            
            %% Updating S %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            updating_r(S)
            
            
            
            
            
            %% Objects of the Complex Domain %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%
            % Button group objects
            %%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.slide_rc.String{S.slide_rc.Value}, 'Complex')
            
            %%% Eraze all the objects of the fitting problem.
            try
                if ishandle(S.pb_init_r)
                    delete(S.pb_init_r)
                    S = rmfield(S, 'pb_init_r');
                    delete(S.pb_xyz_r)
                    S = rmfield(S, 'pb_xyz_r');
                    delete(S.pb_xy_r)
                    S = rmfield(S, 'pb_xy_r');
                    delete(S.pb_yz_r)
                    S = rmfield(S, 'pb_yz_r');
                    delete(S.pb_xz_r)
                    S = rmfield(S, 'pb_xz_r');
                    delete(S.pb_x_r)
                    S = rmfield(S, 'pb_x_r');
                    delete(S.pb_y_r)
                    S = rmfield(S, 'pb_y_r');
                    delete(S.pb_z_r)
                    S = rmfield(S, 'pb_z_r');
                    delete(S.pb_reset_r)
                    S = rmfield(S, 'pb_reset_r');
                    delete(S.ax_data_r)
                    S = rmfield(S, 'ax_data_r');
                    delete(S.ax_vector_r)
                    S = rmfield(S, 'ax_vector_r');
                    delete(S.ax_polar_r)
                    S = rmfield(S, 'ax_polar_r');
                    delete(S.ax_cylindrical_r)
                    S = rmfield(S, 'ax_cylindrical_r');
                    delete(S.et_process_r)
                    S = rmfield(S, 'et_process_r');
                end
                % When nothing to delete, pass.
            catch
            end
            
            %%% Do not allow switching to the same category.
            try
                if ishandle(S.pb_init_c)
                    return
                end
                % When nothing overlaps, pass.
            catch
            end
            
            %%% Initializing button
            S.pb_init_c = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 550, 180, 30], ...
                'string', 'Initializing', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% 2D button: xy
            S.pb_xy_c = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 500, 180, 30], ...
                'string', '2D: x, y', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.9, 0.9, 0.9]);
            
            %%% Reset button
            S.pb_reset_c = uicontrol('style', 'pushbutton', ...
                'unit', 'pix', ...
                'position', [60, 70, 180, 50], ...
                'string', 'Reset', ...
                'fontsize', 15, ...
                'horizontalalign', 'center', ...
                'backgroundcolor', [0.7, 0.7, 0.7]);
            
            
            
            %%%%%%
            % Axes
            %%%%%%
            
            %%% Data plot
            S.ax_data_c = axes('units', 'pixels', ...
                'position', [300, 375, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_data_c, 'Data in Cartesian', 'fontsize', 15)
            
            %%% Vector plot
            S.ax_vector_c = axes('units', 'pixels', ...
                'position', [750, 375, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_vector_c, 'Vector in Cartesian', 'fontsize', 15)
            
            %%% Polar plot
            S.ax_polar_c = polaraxes('units', 'pixels', ...
                'position', [300, 50, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_polar_c, ...
                'Data in Polar', 'fontsize', 15)
            
            %%% Cylindrical plot
            S.ax_cylindrical_c = axes('units', 'pixels', ...
                'position', [750, 50, 400, 275], ...
                'NextPlot', 'replacechildren');
            title(S.ax_cylindrical_c, ...
                'Data in Cylindrical', 'fontsize', 15)
            
            
            
            %%%%%%%%%%%%%
            % Process bar
            %%%%%%%%%%%%%
            S.et_process_c = uicontrol('style', 'edit', ...
                'units', 'pix', ...
                'position', [595, 660, 260, 30], ...
                'string', 'x(f_1), y(factor_2) * i', ...
                'fontsize', 20, ...
                'ForegroundColor', 'red', ...
                'backgroundcolor', [1, 1, 1], ...
                'horizontalalign', 'center', ...
                'fontweight', 'bold');
            
            
            
            
            
            
            %% Updating S %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            updating_c(S)
        end
    end





%% Real Callbacks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize button callback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function pb_init_r_callback(~, ~, varargin)
        S = varargin{1};
        % Entering string
        set(S.et_process_r, 'string', 'Initializing...')
        drawnow
        
        %%% CENTERIZED samples (totally out of sink with zero correlation)
        S.x_init = zscore(randi([0, 100], [100, 1]));
        S.y_init = zscore(randi([0, 100], [100, 1]));
        S.z_init = zscore(randi([0, 100], [100, 1]));
        
        %%% Data plot: O
        hold(S.ax_data_r, 'on')
        grid(S.ax_data_r, 'on')
        xlim(S.ax_data_r, [min(S.x_init), max(S.x_init)])
        ylim(S.ax_data_r, [min(S.y_init), max(S.y_init)])
        zlim(S.ax_data_r, [min(S.z_init), max(S.z_init)])
        xlabel(S.ax_data_r, 'factor\_1')
        ylabel(S.ax_data_r, 'factor\_2')
        zlabel(S.ax_data_r, 'factor\_3')
        view(S.ax_data_r, ...
            [max(S.x_init), max(S.y_init), max(S.z_init)])
        
        %%% Vector plot: O
        hold(S.ax_vector_r, 'on')
        grid(S.ax_vector_r, 'on')
        xlim(S.ax_vector_r, [-2*norm(S.x_init), 2*norm(S.x_init)])
        ylim(S.ax_vector_r, [-2*norm(S.y_init), 2*norm(S.y_init)])
        zlim(S.ax_vector_r, [-2*norm(S.z_init), 2*norm(S.z_init)])
        xlabel(S.ax_vector_r, 'factor\_1')
        ylabel(S.ax_vector_r, 'factor\_2')
        zlabel(S.ax_vector_r, 'factor\_3')
        view(S.ax_vector_r, ...
            [2*norm(S.x_init), 2*norm(S.y_init), 2*norm(S.z_init)])
        
        %%% Polar plot: O
        [~, rho, ~] = cart2pol(S.x_init, S.y_init, S.z_init);
        hold(S.ax_polar_r, 'on')
        rlim(S.ax_polar_r, [0, max(rho)])
        
        %%% Cylindrical plot: O
        hold(S.ax_cylindrical_r, 'on')
        grid(S.ax_cylindrical_r, 'on')
        xlim(S.ax_cylindrical_r, [3*min(S.x_init), 3*max(S.x_init)])
        ylim(S.ax_cylindrical_r, [3*min(S.y_init), 3*max(S.y_init)])
        zlim(S.ax_cylindrical_r, [3*min(S.z_init), 3*max(S.z_init)])
        % Theta axis
        plot3(S.ax_cylindrical_r, ...
            3*min(S.x_init):0.1:3*max(S.x_init), ...
            zeros(length(3*min(S.x_init):0.1:3*max(S.x_init)), 1), ...
            zeros(length(3*min(S.x_init):0.1:3*max(S.x_init)), 1), 'r')
        % Rho axis
        plot3(S.ax_cylindrical_r, ...
            zeros(length(3*min(S.y_init):0.1:3*max(S.y_init)), 1), ...
            3*min(S.y_init):0.1:3*max(S.y_init), ...
            zeros(length(3*min(S.y_init):0.1:3*max(S.y_init)), 1), 'g')
        % z axis
        plot3(S.ax_cylindrical_r, ...
            zeros(length(3*min(S.z_init):0.1:3*max(S.z_init)), 1), ...
            zeros(length(3*min(S.z_init):0.1:3*max(S.z_init)), 1), ...
            3*min(S.z_init):0.1:3*max(S.z_init), 'b')
        xlabel(S.ax_cylindrical_r, 'theta')
        ylabel(S.ax_cylindrical_r, 'rho')
        zlabel(S.ax_cylindrical_r, 'z')
        view(S.ax_cylindrical_r, ...
            [3*max(S.x_init), 3*max(S.y_init), 3*max(S.z_init)])
        
        %%% Updating S
        % Escaping string
        set(S.et_process_r, 'string', 'Initializing completed')
        % From-to connection for next plot
        S.from = 'Initializing completed';
        updating_r(S)
    end



%%%%%%%%%%%%%%%%%%%%%
% xyz button callback
%%%%%%%%%%%%%%%%%%%%%
    function pb_xyz_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow
        
        %%% Plotting
        % From-to connection for next plot
        S.to = '3D: f_1, f_2, f_3';
        plotting(S) % Updating is included here.
        
        %%% Escaping string
        set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
    end



%%%%%%%%%%%%%%%%%%%%
% xy button callback
%%%%%%%%%%%%%%%%%%%%
    function pb_xy_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow
        
        %%% Plotting
        % From-to connection for next plot
        S.to = '2D: f_1, f_2';
        plotting(S) % Updating is included here.
        
        %%% Escaping string
        set(S.et_process_r, 'string', '2D: f_1, f_2')
    end



%%%%%%%%%%%%%%%%%%%%
% yz button callback
%%%%%%%%%%%%%%%%%%%%
    function pb_yz_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow
        
        %%% Plotting
        % From-to connection for next plot
        S.to = '2D: f_2, f_3';
        plotting(S) % Updating is included here.
        
        %%% Escaping string
        set(S.et_process_r, 'string', '2D: f_2, f_3')
    end



%%%%%%%%%%%%%%%%%%%%
% xz button callback
%%%%%%%%%%%%%%%%%%%%
    function pb_xz_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow
        
        %%% Plotting
        % From-to connection for next plot
        S.to = '2D: f_1, f_3';
        plotting(S) % Updating is included here.
        
        %%% Escaping string
        set(S.et_process_r, 'string', '2D: f_1, f_3')
    end



%%%%%%%%%%%%%%%%%%%
% x button callback
%%%%%%%%%%%%%%%%%%%
    function pb_x_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow % Updating is included here.
        
        %%% Plotting
        % From-to connection for next plot
        S.to = '1D: f_1';
        plotting(S)
        
        %%% Escaping string
        set(S.et_process_r, 'string', '1D: f_1')
    end



%%%%%%%%%%%%%%%%%%%
% y button callback
%%%%%%%%%%%%%%%%%%%
    function pb_y_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow
        
        %%% Plotting
        % From-to connection for next plot
        S.to = '1D: f_2';
        plotting(S) % Updating is included here.
        
        %%% Escaping string
        set(S.et_process_r, 'string', '1D: f_2')
    end



%%%%%%%%%%%%%%%%%%%
% z button callback
%%%%%%%%%%%%%%%%%%%
    function pb_z_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow
        
        %%% Plotting
        % From-to connection for next plot
        S.to = '1D: f_3';
        plotting(S) % Updating is included here.
        
        %%% Escaping string
        set(S.et_process_r, 'string', '1D: f_3')
    end



%%%%%%%%%%%%%%%%%%%%%%%
% Reset button callback
%%%%%%%%%%%%%%%%%%%%%%%
    function pb_reset_r_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_r, 'string', 'Processing...')
        drawnow
        
        %%% Resetting
        % Since resetting all the other settings is computationally
        % expensive, we just clear the axes.
        cla(S.ax_data_r)
        cla(S.ax_vector_r)
        cla(S.ax_polar_r)
        cla(S.ax_cylindrical_r)
        
        %%% Escaping string
        set(S.et_process_r, 'string', ...
            'Done, please re-initialize')
        
        %%% Updating S
        updating_r(S)
    end





%% Complex Callbacks %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize button callback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function pb_init_c_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_c, 'string', 'Initializing...')
        drawnow
        
        %%% CENTERIZED samples (totally out of sink with zero correlation)
        S.x_init = zscore(randi([0, 100], [100, 1]));
        S.y_init = zscore(randi([0, 100], [100, 1]));
        
        %%% Data plot: O
        hold(S.ax_data_c, 'on')
        grid(S.ax_data_c, 'on')
        xlim(S.ax_data_c, [min(S.x_init), max(S.x_init)])
        ylim(S.ax_data_c, [min(S.y_init), max(S.y_init)])
        xlabel(S.ax_data_c, ['factor\_1                          ', ...
            '                                           factor\_1'])
        ylabel(S.ax_data_c, 'factor\_2 * imaginary')
        
        %%% Vector plot: O
        hold(S.ax_vector_c, 'on')
        grid(S.ax_vector_c, 'on')
        xlim(S.ax_vector_c, [-2*norm(S.x_init), 2*norm(S.x_init)])
        ylim(S.ax_vector_c, [-2*norm(S.y_init), 2*norm(S.y_init)])
        xlabel(S.ax_vector_c, 'factor\_1')
        ylabel(S.ax_vector_c, 'factor\_2 * imaginary')
        
        %%% Polar plot: O
        [~, rho] = cart2pol(S.x_init, S.y_init);
        hold(S.ax_polar_c, 'on')
        rlim(S.ax_polar_c, [0, max(rho)])
        
        %%% Cylindrical plot: O
        hold(S.ax_cylindrical_c, 'on')
        grid(S.ax_cylindrical_c, 'on')
        xlim(S.ax_cylindrical_c, [3*min(S.x_init), 3*max(S.x_init)])
        ylim(S.ax_cylindrical_c, [3*min(S.y_init), 3*max(S.y_init)])
        % Theta axis
        plot(S.ax_cylindrical_c, ...
            3*min(S.x_init):0.1:3*max(S.x_init), ...
            zeros(length(3*min(S.x_init):0.1:3*max(S.x_init)), 1), 'r')
        % Rho axis
        plot(S.ax_cylindrical_c, ...
            zeros(length(3*min(S.y_init):0.1:3*max(S.y_init)), 1), ...
            3*min(S.y_init):0.1:3*max(S.y_init), 'g')
        xlabel(S.ax_cylindrical_c, 'theta')
        ylabel(S.ax_cylindrical_c, 'rho')
        
        %%% Escaping string
        set(S.et_process_c, 'string', 'Initializing completed')
        
        %%% Updating S
        updating_c(S)
    end



%%%%%%%%%%%%%%%%%%%%
% xy button callback
%%%%%%%%%%%%%%%%%%%%
    function pb_xy_c_callback(~, ~, varargin)
        S = varargin{1};
        
        %%% Entering string
        set(S.et_process_c, 'string', 'Processing...')
        drawnow
        
        %%% Plotting
        % We adopted the nested plotting(S) function to realize
        % dimensional transitions in the real domain problem,
        % but since, in complex problem, it's now merely one case plotting
        % without any kind of transitions, and also for computational
        % efficiency, we just plot this single case
        % without any nested function.
        % Data plot
        S.xy_data_c = plot(S.ax_data_c, S.x_init, S.y_init, 'm+');
        % Vector plot
        x_1 = norm(S.x_init);
        y_1 = 0;
        x_2 = norm(S.y_init) * ...
            cos(acos(corr(S.x_init, S.y_init)));
        y_2 = norm(S.y_init) * ...
            sin(acos(corr(S.x_init, S.y_init)));
        S.xy_vector_c = plot(S.ax_vector_c, ...
            [0, x_1], [0, y_1], 'r-', ...
            [0, x_2], [0, y_2], 'g-', ...
            'linewidth', 3);
        % Polar plot
        [theta, rho] = cart2pol(S.x_init, S.y_init);
        S.xy_polar_c = polarplot(S.ax_polar_c, ...
            theta, rho, 'm+');
        % Cylindrical plot
        S.xy_cylindrical_c = plot(S.ax_cylindrical_c, ...
            theta, rho, 'm+');
        
        %%% Escaping string
        set(S.et_process_c, 'string', '2D: f_1, f_2')
        
        %%% Updating S
        updating_c(S)
    end



%%%%%%%%%%%%%%%%%%%%%%%
% Reset button callback
%%%%%%%%%%%%%%%%%%%%%%%
    function pb_reset_c_callback(~, ~, varargin)
        
        %%% Entering string
        set(S.et_process_c, 'string', 'Processing...')
        drawnow
        
        %%% Resetting
        cla(S.ax_data_c)
        cla(S.ax_vector_c)
        cla(S.ax_polar_c)
        cla(S.ax_cylindrical_c)
        
        %%% Escaping string
        set(S.et_process_c, 'string', ...
            'Done, please re-initialize')
        
        %%% Updating S
        updating_c(S)
    end





%% Plotting function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plotting(S)
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Same button transitions: 8 cases
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if strcmp(S.from, S.to)
            return
        end
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % From initial to others: 7 cases
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if strcmp(S.from, 'Initializing completed')
            switch S.to
                
                %%% To 3D: f_1, f_2, f_3
                case '3D: f_1, f_2, f_3'
                    % No shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init;
                    % Data plot
                    S.xyz_data_r = plot3(S.ax_data_r, ...
                        S.x_shift, S.y_shift, S.z_shift, 'm+');
                    % Vector plot
                    [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                        vectorizing(S.x_shift, S.y_shift, S.z_shift, ...
                        S.x_init, S.y_init, S.z_init);
                    S.xyz_vector_r = plot3(S.ax_vector_r, ...
                        [0, x_1], [0, y_1], [0, 0], 'r-', ...
                        [0, x_2], [0, y_2], [0, 0], 'g-', ...
                        [0, 0], [0, y_3], [0, z_3], 'b-', ...
                        'linewidth', 3);
                    % Polar plot
                    % Cylindrical plot
                    [theta, rho, z] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.xyz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                        theta, rho, z, 'm+');
                    % Escaping string
                    set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
                    % From-to connection for next plot
                    S.from = '3D: f_1, f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_2
                case '2D: f_1, f_2'
                    % z shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init;
                    S.z_shift = zeros(length(S.z_init), 1);
                    % Data plot
                    S.xy_data_r = plot3(S.ax_data_r, ...
                        S.x_shift, S.y_shift, S.z_shift, 'm+');
                    % Vector plot
                    [x_1, y_1, x_2, y_2, ~, ~] = ...
                        vectorizing(S.x_shift, S.y_shift, S.z_shift, ...
                        S.x_init, S.y_init, S.z_init);
                    S.xy_vector_r = plot3(S.ax_vector_r, ...
                        [0, x_1], [0, y_1], [0, 0], 'r-', ...
                        [0, x_2], [0, y_2], [0, 0], 'g-', ...
                        'linewidth', 3);
                    % Polar plot
                    [theta, rho, ~] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.xy_polar_r = polarplot(S.ax_polar_r, ...
                        theta, rho, 'm+');
                    % Cylindrical plot
                    [theta, rho, z] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.xy_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                        theta, rho, z, 'm+');
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_2')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_2, f_3
                case '2D: f_2, f_3'
                    % x shift
                    S.x_shift = zeros(length(S.x_init), 1);
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init;
                    % Data plot
                    S.yz_data_r = plot3(S.ax_data_r, ...
                        S.x_shift, S.y_shift, S.z_shift, 'm+');
                    % Vector plot
                    [~, ~, x_2, y_2, y_3, z_3] = ...
                        vectorizing(S.x_shift, S.y_shift, S.z_shift, ...
                        S.x_init, S.y_init, S.z_init);
                    S.yz_vector_r = plot3(S.ax_vector_r, ...
                        [0, x_2], [0, y_2], [0, 0], 'g-', ...
                        [0, 0], [0, y_3], [0, z_3], 'b-', ...
                        'linewidth', 3);
                    % Polar plot
                    [theta, rho, ~] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.yz_polar_r = polarplot(S.ax_polar_r, ...
                        theta, rho, 'm+');
                    % Cylindrical plot
                    [theta, rho, z] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.yz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                        theta, rho, z, 'm+');
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_2, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_3
                case '2D: f_1, f_3'
                    % y shift
                    S.x_shift = S.x_init;
                    S.y_shift = zeros(length(S.y_init), 1);
                    S.z_shift = S.z_init;
                    % Data plot
                    S.xz_data_r = plot3(S.ax_data_r, ...
                        S.x_shift, S.y_shift, S.z_shift, 'm+');
                    % Vector plot
                    [x_1, y_1, ~, ~, y_3, z_3] = ...
                        vectorizing(S.x_shift, S.y_shift, S.z_shift, ...
                        S.x_init, S.y_init, S.z_init);
                    S.xz_vector_r = plot3(S.ax_vector_r, ...
                        [0, x_1], [0, y_1], [0, 0], 'r-', ...
                        [0, 0], [0, y_3], [0, z_3], 'b-', ...
                        'linewidth', 3);
                    % Polar plot
                    [theta, rho, ~] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.xz_polar_r = polarplot(S.ax_polar_r, ...
                        theta, rho, 'm+');
                    % Cylindrical plot
                    [theta, rho, z] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.xz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                        theta, rho, z, 'm+');
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_1
                case '1D: f_1'
                    % y, z shift
                    S.x_shift = S.x_init;
                    S.y_shift = zeros(length(S.y_init), 1);
                    S.z_shift = zeros(length(S.z_init), 1);
                    % Data plot
                    S.x_data_r = plot3(S.ax_data_r, ...
                        S.x_shift, S.y_shift, S.z_shift, 'r+');
                    % Vector plot
                    [x_1, y_1, ~, ~, ~, ~] = ...
                        vectorizing(S.x_shift, S.y_shift, S.z_shift, ...
                        S.x_init, S.y_init, S.z_init);
                    S.x_vector_r = plot3(S.ax_vector_r, ...
                        [0, x_1], [0, y_1], [0, 0], 'r-', ...
                        'linewidth', 3);
                    % Polar plot
                    [theta, rho, ~] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.x_polar_r = polarplot(S.ax_polar_r, ...
                        theta, rho, 'r+');
                    % Cylindrical plot
                    [theta, rho, z] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.x_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                        theta, rho, z, 'r+');
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_1')
                    % From-to connection for next plot
                    S.from = '1D: f_1';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_2
                case '1D: f_2'
                    % x, z shift
                    S.x_shift = zeros(length(S.x_init), 1);
                    S.y_shift = S.y_init;
                    S.z_shift = zeros(length(S.z_init), 1);
                    % Data plot
                    S.y_data_r = plot3(S.ax_data_r, ...
                        S.x_shift, S.y_shift, S.z_shift, 'g+');
                    % Vector plot
                    [~, ~, x_2, y_2, ~, ~] = ...
                        vectorizing(S.x_shift, S.y_shift, S.z_shift, ...
                        S.x_init, S.y_init, S.z_init);
                    S.y_vector_r = plot3(S.ax_vector_r, ...
                        [0, x_2], [0, y_2], [0, 0], 'g-', ...
                        'linewidth', 3);
                    % Polar plot
                    [theta, rho, ~] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.y_polar_r = polarplot(S.ax_polar_r, ...
                        theta, rho, 'g+');
                    % Cylindrical plot
                    [theta, rho, z] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.y_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                        theta, rho, z, 'g+');
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_2')
                    % From-to connection for next plot
                    S.from = '1D: f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_3
                case '1D: f_3'
                    % x, y shift
                    S.x_shift = zeros(length(S.x_init), 1);
                    S.y_shift = zeros(length(S.y_init), 1);
                    S.z_shift = S.z_init;
                    % Data plot
                    S.z_data_r = plot3(S.ax_data_r, ...
                        S.x_shift, S.y_shift, S.z_shift, 'b+');
                    % Vector plot
                    [~, ~, ~, ~, y_3, z_3] = ...
                        vectorizing(S.x_shift, S.y_shift, S.z_shift, ...
                        S.x_init, S.y_init, S.z_init);
                    S.z_vector_r = plot3(S.ax_vector_r, ...
                        [0, 0], [0, y_3], [0, z_3], 'b-', ...
                        'linewidth', 3);
                    % Polar plot
                    [theta, rho, ~] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.z_polar_r = polarplot(S.ax_polar_r, ...
                        theta, rho, 'b+');
                    % Cylindrical plot
                    [theta, rho, z] = ...
                        cart2pol(S.x_shift, S.y_shift, S.z_shift);
                    S.z_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                        theta, rho, z, 'b+');
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_3')
                    % From-to connection for next plot
                    S.from = '1D: f_3';
                    % Updating S
                    updating_r(S)
            end
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % From 3D to others: 6 cases
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.from, '3D: f_1, f_2, f_3')
            switch S.to
                
                %%% To 2D: f_1, f_2
                case '2D: f_1, f_2'
                    delete(S.xyz_data_r)
                    delete(S.xyz_vector_r)
                    delete(S.xyz_cylindrical_r)
                    % z shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init; % will be shifted.
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.z_shift) ~= 0
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_2
                        if sum(S.z_shift) == 0
                            % Data plot
                            S.xy_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xy_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_2')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_2, f_3
                case '2D: f_2, f_3'
                    delete(S.xyz_data_r)
                    delete(S.xyz_vector_r)
                    delete(S.xyz_cylindrical_r)
                    % x shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init; % will be shifted.
                    x_target = zeros(length(S.x_shift), 1);
                    while sum(S.x_shift) ~= 0
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_2, f_3
                        if sum(S.x_shift) == 0
                            % Data plot
                            S.yz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [~, ~, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.yz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_2, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_3
                case '2D: f_1, f_3'
                    delete(S.xyz_data_r)
                    delete(S.xyz_vector_r)
                    delete(S.xyz_cylindrical_r)
                    % y shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = S.z_init;
                    y_target = zeros(length(S.y_shift), 1);
                    while sum(S.y_shift) ~= 0
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_3
                        if sum(S.y_shift) == 0
                            % Data plot
                            S.xz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_1
                case '1D: f_1'
                    delete(S.xyz_data_r)
                    delete(S.xyz_vector_r)
                    delete(S.xyz_cylindrical_r)
                    % y, z shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = S.z_init; % will be shifted.
                    y_target = zeros(length(S.y_shift), 1);
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.y_shift) ~= 0 || sum(S.z_shift) ~= 0
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 1D: f_1
                        if sum(S.y_shift) == 0 && sum(S.z_shift) == 0
                            % Data plot
                            S.x_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'r+');
                            % Vector plot
                            [x_1, y_1, ~, ~, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.x_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.x_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'r+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.x_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'r+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_1')
                    % From-to connection for next plot
                    S.from = '1D: f_1';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_2
                case '1D: f_2'
                    delete(S.xyz_data_r)
                    delete(S.xyz_vector_r)
                    delete(S.xyz_cylindrical_r)
                    % x, z shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init; % will be shifted.
                    x_target = zeros(length(S.x_shift), 1);
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.x_shift) ~= 0 || sum(S.z_shift) ~= 0
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 1D: f_2
                        if sum(S.x_shift) == 0 && sum(S.z_shift) == 0
                            % Data plot
                            S.y_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'g+');
                            % Vector plot
                            [~, ~, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.y_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'g+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'g+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_2')
                    % From-to connection for next plot
                    S.from = '1D: f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_3
                case '1D: f_3'
                    delete(S.xyz_data_r)
                    delete(S.xyz_vector_r)
                    delete(S.xyz_cylindrical_r)
                    % x, y shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = S.z_init;
                    x_target = zeros(length(S.x_shift), 1);
                    y_target = zeros(length(S.y_shift), 1);
                    while sum(S.x_shift) ~= 0 || sum(S.y_shift) ~= 0
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 1D: f_3
                        if sum(S.x_shift) == 0 && sum(S.y_shift) == 0
                            % Data plot
                            S.z_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'b+');
                            % Vector plot
                            [~, ~, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.z_vector_r = plot3(S.ax_vector_r, ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'b+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'b+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_3')
                    % From-to connection for next plot
                    S.from = '1D: f_3';
                    % Updating S
                    updating_r(S)
            end
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % From 2D (f_1, f_2) to others: 6 cases
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.from, '2D: f_1, f_2')
            switch S.to
                
                %%% To 3D: f_1, f_2, f_3
                case '3D: f_1, f_2, f_3'
                    delete(S.xy_data_r)
                    delete(S.xy_vector_r)
                    delete(S.xy_polar_r)
                    delete(S.xy_cylindrical_r)
                    % z shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init;
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    z_target = S.z_init;
                    while sum(S.z_shift) ~= sum(z_target)
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 3D: f_1, f_2, f_3
                        if sum(S.z_shift) == sum(z_target)
                            % Data plot
                            S.xyz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xyz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xyz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
                    % From-to connection for next plot
                    S.from = '3D: f_1, f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_3
                case '2D: f_1, f_3'
                    delete(S.xy_data_r)
                    delete(S.xy_vector_r)
                    delete(S.xy_polar_r)
                    delete(S.xy_cylindrical_r)
                    % y, z shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = zeros(...
                        length(S.z_shift), 1); % will be shifted.
                    z_target = S.z_init;
                    y_target = ...
                        zeros(length(S.y_shift), 1);
                    while sum(S.y_shift) ~= 0 || ...
                            sum(z_target) ~= sum(S.z_shift)
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_3
                        if sum(S.y_shift) == 0 && ...
                                sum(z_target) == sum(S.z_shift)
                            % Date plot
                            S.xz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_2, f_3
                case '2D: f_2, f_3'
                    delete(S.xy_data_r)
                    delete(S.xy_vector_r)
                    delete(S.xy_polar_r)
                    delete(S.xy_cylindrical_r)
                    % x, z shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = zeros(...
                        length(S.z_shift), 1); % will be shifted.
                    z_target = S.z_init;
                    x_target = ...
                        zeros(length(S.x_shift), 1);
                    while sum(S.x_shift) ~= 0 || ...
                            sum(z_target) ~= sum(S.z_shift)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_2, f_3
                        if sum(S.x_shift) == 0 && ...
                                sum(z_target) == sum(S.z_shift)
                            % Date plot
                            S.yz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [~, ~, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.yz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_2, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_1
                case '1D: f_1'
                    delete(S.xy_data_r)
                    delete(S.xy_vector_r)
                    delete(S.xy_polar_r)
                    delete(S.xy_cylindrical_r)
                    % y shift
                    S.x_shift = S.x_init;
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = zeros(length(S.z_shift), 1); % Already 0
                    y_target = zeros(length(S.y_shift), 1);
                    while sum(S.y_shift) ~= 0
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Date plot
                        S.xy_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, ~, ~] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xy_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xy_data_r)
                        delete(S.xy_polar_r)
                        delete(S.xy_vector_r)
                        delete(S.xy_cylindrical_r)
                        % Last stance of 1D: f_1
                        if sum(S.y_shift) == 0
                            % Data plot
                            S.x_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'r+');
                            % Vector plot
                            [x_1, y_1, ~, ~, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.x_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.x_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'r+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.x_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'r+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_1')
                    % From-to connection for next plot
                    S.from = '1D: f_1';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_2
                case '1D: f_2'
                    delete(S.xy_data_r)
                    delete(S.xy_vector_r)
                    delete(S.xy_polar_r)
                    delete(S.xy_cylindrical_r)
                    % x shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = zeros(length(S.z_shift), 1); % Already 0
                    x_target = zeros(length(S.x_shift), 1);
                    while sum(S.x_shift) ~= 0
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Date plot
                        S.xy_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, ~, ~] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xy_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xy_data_r)
                        delete(S.xy_polar_r)
                        delete(S.xy_vector_r)
                        delete(S.xy_cylindrical_r)
                        % Last stance of 1D: f_2
                        if sum(S.x_shift) == 0
                            % Data plot
                            S.y_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'g+');
                            % Vector plot
                            [~, ~, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.y_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'g+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'g+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_2')
                    % From-to connection for next plot
                    S.from = '1D: f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_3
                case '1D: f_3'
                    delete(S.xy_data_r)
                    delete(S.xy_vector_r)
                    delete(S.xy_polar_r)
                    delete(S.xy_cylindrical_r)
                    % x, y, z shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    x_target = zeros(length(S.x_shift), 1);
                    y_target = zeros(length(S.y_shift), 1);
                    z_target = S.z_init;
                    while sum(S.x_shift) ~= 0 || ...
                            sum(S.y_shift) ~= 0 || ...
                            sum(S.z_shift) ~= sum(S.z_init)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 1D: f_3
                        if sum(S.x_shift) == 0 && ...
                                sum(S.y_shift) == 0 && ...
                                sum(S.z_shift) == sum(S.z_init)
                            % Data plot
                            S.z_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'b+');
                            % Vector plot
                            [~, ~, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.z_vector_r = plot3(S.ax_vector_r, ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'b+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'b+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_3')
                    % From-to connection for next plot
                    S.from = '1D: f_3';
                    % Updating S
                    updating_r(S)
            end
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % From 2D (f_2, f_3) to others: 6 cases
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.from, '2D: f_2, f_3')
            switch S.to
                
                %%% To 3D: f_1, f_2, f_3
                case '3D: f_1, f_2, f_3'
                    delete(S.yz_data_r)
                    delete(S.yz_vector_r)
                    delete(S.yz_polar_r)
                    delete(S.yz_cylindrical_r)
                    % x shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init;
                    x_target = S.x_init;
                    while sum(S.x_shift) ~= sum(x_target)
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 3D: f_1, f_2, f_3
                        if sum(S.x_shift) == sum(x_target)
                            % Data plot
                            S.xyz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xyz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xyz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
                    % From-to connection for next plot
                    S.from = '3D: f_1, f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_2
                case '2D: f_1, f_2'
                    delete(S.yz_data_r)
                    delete(S.yz_vector_r)
                    delete(S.yz_polar_r)
                    delete(S.yz_cylindrical_r)
                    % x, z shift
                    S.x_shift = zeros(...
                        length(S.x_shift), 1); % will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init; % will be shifted.
                    x_target = S.x_init;
                    z_target = ...
                        zeros(length(S.z_shift), 1);
                    while sum(S.z_shift) ~= 0 || ...
                            sum(x_target) ~= sum(S.x_shift)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_2
                        if sum(S.z_shift) == 0 && ...
                                sum(x_target) == sum(S.x_shift)
                            % Data plot
                            S.xy_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xy_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_2')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_3
                case '2D: f_1, f_3'
                    delete(S.yz_data_r)
                    delete(S.yz_vector_r)
                    delete(S.yz_polar_r)
                    delete(S.yz_cylindrical_r)
                    % x, y shift
                    S.x_shift = zeros(...
                        length(S.x_shift), 1); % will be shifted.
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = S.z_init;
                    x_target = S.x_init;
                    y_target = ...
                        zeros(length(S.y_shift), 1);
                    while sum(S.y_shift) ~= 0 || ...
                            sum(x_target) ~= sum(S.x_shift)
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_3
                        if sum(S.y_shift) == 0 && ...
                                sum(x_target) == sum(S.x_shift)
                            % Date plot
                            S.xz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_1
                case '1D: f_1'
                    delete(S.yz_data_r)
                    delete(S.yz_vector_r)
                    delete(S.yz_polar_r)
                    delete(S.yz_cylindrical_r)
                    % x, y, z shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % will be shifted.
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = S.z_init; % will be shifted.
                    x_target = S.x_init;
                    y_target = zeros(length(S.y_shift), 1);
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.y_shift) ~= 0 || ...
                            sum(S.z_shift) ~= 0 || ...
                            sum(S.x_shift) ~= sum(x_target)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 1D: f_1
                        if sum(S.y_shift) == 0 && ...
                                sum(S.z_shift) == 0 && ...
                                sum(S.x_shift) == sum(x_target)
                            % Data plot
                            S.x_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'r+');
                            % Vector plot
                            [x_1, y_1, ~, ~, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.x_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'r+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'r+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_1')
                    % From-to connection for next plot
                    S.from = '1D: f_1';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_2
                case '1D: f_2'
                    delete(S.yz_data_r)
                    delete(S.yz_vector_r)
                    delete(S.yz_polar_r)
                    delete(S.yz_cylindrical_r)
                    % z shift
                    S.x_shift = zeros(length(S.x_shift), 1); % Already 0
                    S.y_shift = S.y_init;
                    S.z_shift = S.z_init; % will be shifted.
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.z_shift) ~= 0
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.yz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [~, ~, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.yz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.yz_data_r)
                        delete(S.yz_vector_r)
                        delete(S.yz_polar_r)
                        delete(S.yz_cylindrical_r)
                        % Last stance of 1D: f_2
                        if sum(S.z_shift) == 0
                            % Data plot
                            S.y_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'g+');
                            % Vector plot
                            [~, ~, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.y_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'g+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'g+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_2')
                    % From-to connection for next plot
                    S.from = '1D: f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_3
                case '1D: f_3'
                    delete(S.yz_data_r)
                    delete(S.yz_vector_r)
                    delete(S.yz_polar_r)
                    delete(S.yz_cylindrical_r)
                    % y shift
                    S.x_shift = zeros(length(S.x_shift), 1); % Already 0
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = S.z_init;
                    y_target = zeros(length(S.y_shift), 1);
                    while sum(S.y_shift) ~= 0
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Data plot
                        S.yz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [~, ~, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.yz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.yz_data_r)
                        delete(S.yz_vector_r)
                        delete(S.yz_polar_r)
                        delete(S.yz_cylindrical_r)
                        % Last stance of 1D: f_3
                        if sum(S.y_shift) == 0
                            % Data plot
                            S.z_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'b+');
                            % Vector plot
                            [~, ~, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.z_vector_r = plot3(S.ax_vector_r, ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'b+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'b+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_3')
                    % From-to connection for next plot
                    S.from = '1D: f_3';
                    % Updating S
                    updating_r(S)
            end
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % From 2D (f_1, f_3) to others: 6 cases
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.from, '2D: f_1, f_3')
            switch S.to
                
                %%% To 3D: f_1, f_2, f_3
                case '3D: f_1, f_2, f_3'
                    delete(S.xz_data_r)
                    delete(S.xz_vector_r)
                    delete(S.xz_polar_r)
                    delete(S.xz_cylindrical_r)
                    % y shift
                    S.x_shift = S.x_init;
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init;
                    y_target = S.y_init;
                    while sum(S.y_shift) ~= sum(y_target)
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 3D: f_1, f_2, f_3
                        if sum(S.y_shift) == sum(y_target)
                            % Data plot
                            S.xyz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xyz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xyz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
                    % From-to connection for next plot
                    S.from = '3D: f_1, f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_2
                case '2D: f_1, f_2'
                    delete(S.xz_data_r)
                    delete(S.xz_vector_r)
                    delete(S.xz_polar_r)
                    delete(S.xz_cylindrical_r)
                    % y, z shift
                    S.x_shift = S.x_init;
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init; % will be shifted.
                    y_target = S.y_init;
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.z_shift) ~= 0 || ...
                            sum(y_target) ~= sum(S.y_shift)
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_2
                        if sum(S.z_shift) == 0 && ...
                                sum(y_target) == sum(S.y_shift)
                            % Data plot
                            S.xy_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xy_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_2')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_2, f_3
                case '2D: f_2, f_3'
                    delete(S.xz_data_r)
                    delete(S.xz_vector_r)
                    delete(S.xz_polar_r)
                    delete(S.xz_cylindrical_r)
                    % x, y shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init;
                    x_target = zeros(length(S.x_shift), 1);
                    y_target = S.y_init;
                    while sum(S.x_shift) ~= 0 || ...
                            sum(y_target) ~= sum(S.y_shift)
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_2, f_3
                        if sum(S.x_shift) == 0 && ...
                                sum(y_target) == sum(S.y_shift)
                            % Data plot
                            S.yz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [~, ~, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.yz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.yz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.yz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_2, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_1
                case '1D: f_1'
                    delete(S.xz_data_r)
                    delete(S.xz_vector_r)
                    delete(S.xz_polar_r)
                    delete(S.xz_cylindrical_r)
                    % z shift
                    S.x_shift = S.x_init;
                    S.y_shift = zeros(length(S.y_shift), 1); % Already 0
                    S.z_shift = S.z_init; % will be shifted.
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.z_shift) ~= 0
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, ~, ~, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xz_data_r)
                        delete(S.xz_vector_r)
                        delete(S.xz_polar_r)
                        delete(S.xz_cylindrical_r)
                        % Last stance of 1D: f_1
                        if sum(S.z_shift) == 0
                            % Data plot
                            S.x_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'r+');
                            % Vector plot
                            [x_1, y_1, ~, ~, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.x_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'r+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'r+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_1')
                    % From-to connection for next plot
                    S.from = '1D: f_1';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_2
                case '1D: f_2'
                    delete(S.xz_data_r)
                    delete(S.xz_vector_r)
                    delete(S.xz_polar_r)
                    delete(S.xz_cylindrical_r)
                    % x, y, z shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init; % will be shifted.
                    x_target = zeros(length(S.x_shift), 1);
                    y_target = S.y_init;
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.x_shift) ~= 0 || ...
                            sum(S.z_shift) ~= 0 || ...
                            sum(S.y_shift) ~= sum(S.y_init)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 1D: f_2
                        if sum(S.x_shift) == 0 && ...
                                sum(S.z_shift) == 0 && ...
                                sum(S.y_shift) == sum(S.y_init)
                            % Data plot
                            S.y_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'g+');
                            % Vector plot
                            [~, ~, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.y_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'g+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'g+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_2')
                    % From-to connection for next plot
                    S.from = '1D: f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_3
                case '1D: f_3'
                    delete(S.xz_data_r)
                    delete(S.xz_vector_r)
                    delete(S.xz_polar_r)
                    delete(S.xz_cylindrical_r)
                    % x shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = zeros(length(S.y_shift), 1); % Already 0;
                    S.z_shift = S.z_init;
                    x_target = zeros(length(S.x_shift), 1);
                    while sum(S.x_shift) ~= 0
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Data plot
                        S.xz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, ~, ~, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xz_data_r)
                        delete(S.xz_vector_r)
                        delete(S.xz_polar_r)
                        delete(S.xz_cylindrical_r)
                        % Last stance of 1D: f_3
                        if sum(S.x_shift) == 0
                            % Data plot
                            S.z_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'b+');
                            % Vector plot
                            [~, ~, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.z_vector_r = plot3(S.ax_vector_r, ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'b+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'b+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_3')
                    % From-to connection for next plot
                    S.from = '1D: f_3';
                    % Updating S
                    updating_r(S)
            end
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % From 1D (f_1) to others: 6 cases
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.from, '1D: f_1')
            switch S.to
                
                %%% To 3D: f_1, f_2, f_3
                case '3D: f_1, f_2, f_3'
                    delete(S.x_data_r)
                    delete(S.x_vector_r)
                    delete(S.x_polar_r)
                    delete(S.x_cylindrical_r)
                    % y, z shift
                    S.x_shift = S.x_init;
                    S.y_shift = ...
                        zeros(length(S.y_shift), 1); % will be shifted.
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    y_target = S.y_init;
                    z_target = S.z_init;
                    while sum(S.y_shift) ~= sum(y_target) || ...
                            sum(S.z_shift) ~= sum(z_target)
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 3D: f_1, f_2, f_3
                        if sum(S.y_shift) == sum(y_target) && ...
                                sum(S.z_shift) == sum(z_target)
                            % Data plot
                            S.xyz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xyz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xyz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
                    % From-to connection for next plot
                    S.from = '3D: f_1, f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_2
                case '2D: f_1, f_2'
                    delete(S.x_data_r)
                    delete(S.x_vector_r)
                    delete(S.x_polar_r)
                    delete(S.x_cylindrical_r)
                    % y shift
                    S.x_shift = S.x_init;
                    S.y_shift = ...
                        zeros(length(S.y_shift), 1); % Will be shifted.
                    S.z_shift = zeros(length(S.z_shift), 1); % Already 0
                    y_target = S.y_init;
                    while sum(S.y_shift) ~= sum(S.y_init)
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Data plot
                        S.xy_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, ~, ~] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xy_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xy_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xy_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xy_data_r)
                        delete(S.xy_vector_r)
                        delete(S.xy_polar_r)
                        delete(S.xy_cylindrical_r)
                        % Last stance of 2D: f_1, f_2
                        if sum(S.y_shift) == sum(S.y_init)
                            % Data plot
                            S.xy_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xy_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_2')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_3
                case '2D: f_1, f_3'
                    delete(S.x_data_r)
                    delete(S.x_vector_r)
                    delete(S.x_polar_r)
                    delete(S.x_cylindrical_r)
                    % z shift
                    S.x_shift = S.x_init;
                    S.y_shift = zeros(length(S.y_shift), 1); % Already 0
                    S.z_shift = zeros(...
                        length(S.z_shift), 1); % will be shifted.
                    z_target = S.z_init;
                    while sum(z_target) ~= sum(S.z_shift)
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, ~, ~, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xz_data_r)
                        delete(S.xz_vector_r)
                        delete(S.xz_polar_r)
                        delete(S.xz_cylindrical_r)
                        % Last stance of 2D: f_1, f_3
                        if sum(z_target) == sum(S.z_shift)
                            % Date plot
                            S.xz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_2, f_3
                case '2D: f_2, f_3'
                    delete(S.x_data_r)
                    delete(S.x_vector_r)
                    delete(S.x_polar_r)
                    delete(S.x_cylindrical_r)
                    % x, y, z shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = ...
                        zeros(length(S.y_shift), 1); % will be shifted.
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    x_target = ...
                        zeros(length(S.x_shift), 1);
                    y_target = S.y_init;
                    z_target = S.z_init;
                    while sum(S.x_shift) ~= 0 || ...
                            sum(y_target) ~= sum(S.y_shift) || ...
                            sum(z_target) ~= sum(S.z_shift)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_2, f_3
                        if sum(S.x_shift) == 0 && ...
                                sum(y_target) == sum(S.y_shift) && ...
                                sum(z_target) == sum(S.z_shift)
                            % Date plot
                            S.yz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [~, ~, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.yz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_2, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_2
                case '1D: f_2'
                    delete(S.x_data_r)
                    delete(S.x_vector_r)
                    delete(S.x_polar_r)
                    delete(S.x_cylindrical_r)
                    % x, y shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = ...
                        zeros(length(S.y_shift), 1); % will be shifted.
                    S.z_shift = zeros(length(S.z_shift), 1); % Already 0
                    x_target = zeros(length(S.x_shift), 1);
                    y_target = S.y_init;
                    while sum(S.x_shift) ~= 0 || ...
                            sum(S.y_shift) ~= sum(S.y_init)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Date plot
                        S.xy_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, ~, ~] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xy_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xy_data_r)
                        delete(S.xy_polar_r)
                        delete(S.xy_vector_r)
                        delete(S.xy_cylindrical_r)
                        % Last stance of 1D: f_2
                        if sum(S.x_shift) == 0 && ...
                                sum(S.y_shift) == sum(S.y_init)
                            % Data plot
                            S.y_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'g+');
                            % Vector plot
                            [~, ~, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.y_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'g+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'g+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_2')
                    % From-to connection for next plot
                    S.from = '1D: f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_3
                case '1D: f_3'
                    delete(S.x_data_r)
                    delete(S.x_vector_r)
                    delete(S.x_polar_r)
                    delete(S.x_cylindrical_r)
                    % x, z shift
                    S.x_shift = S.x_init; % will be shifted.
                    S.y_shift = zeros(length(S.y_shift), 1); % Already 0
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    x_target = zeros(length(S.x_shift), 1);
                    z_target = S.z_init;
                    while sum(S.x_shift) ~= 0 || ...
                            sum(S.z_shift) ~= sum(S.z_init)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, ~, ~, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xz_data_r)
                        delete(S.xz_vector_r)
                        delete(S.xz_polar_r)
                        delete(S.xz_cylindrical_r)
                        % Last stance of 1D: f_3
                        if sum(S.x_shift) == 0 && ...
                                sum(S.z_shift) == sum(S.z_init)
                            % Data plot
                            S.z_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'b+');
                            % Vector plot
                            [~, ~, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.z_vector_r = plot3(S.ax_vector_r, ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'b+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'b+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_3')
                    % From-to connection for next plot
                    S.from = '1D: f_3';
                    % Updating S
                    updating_r(S)
            end
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % From 1D (f_2) to others: 6 cases
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.from, '1D: f_2')
            switch S.to
                
                %%% To 3D: f_1, f_2, f_3
                case '3D: f_1, f_2, f_3'
                    delete(S.y_data_r)
                    delete(S.y_vector_r)
                    delete(S.y_polar_r)
                    delete(S.y_cylindrical_r)
                    % x, z shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    x_target = S.x_init;
                    z_target = S.z_init;
                    while sum(S.x_shift) ~= sum(x_target) || ...
                            sum(S.z_shift) ~= sum(z_target)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 3D: f_1, f_2, f_3
                        if sum(S.x_shift) == sum(x_target) && ...
                                sum(S.z_shift) == sum(z_target)
                            % Data plot
                            S.xyz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xyz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xyz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
                    % From-to connection for next plot
                    S.from = '3D: f_1, f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_2
                case '2D: f_1, f_2'
                    delete(S.y_data_r)
                    delete(S.y_vector_r)
                    delete(S.y_polar_r)
                    delete(S.y_cylindrical_r)
                    % x shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % Will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = zeros(length(S.z_shift), 1); % Already 0
                    x_target = S.x_init;
                    while sum(S.x_shift) ~= sum(S.x_init)
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Data plot
                        S.xy_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, ~, ~] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xy_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xy_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xy_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xy_data_r)
                        delete(S.xy_vector_r)
                        delete(S.xy_polar_r)
                        delete(S.xy_cylindrical_r)
                        % Last stance of 2D: f_1, f_2
                        if sum(S.x_shift) == sum(S.x_init)
                            % Data plot
                            S.xy_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xy_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_2')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_3
                case '2D: f_1, f_3'
                    delete(S.y_data_r)
                    delete(S.y_vector_r)
                    delete(S.y_polar_r)
                    delete(S.y_cylindrical_r)
                    % x, y, z shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % will be shifted.
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = zeros(...
                        length(S.z_shift), 1); % will be shifted.
                    x_target = S.x_init;
                    y_target = zeros(length(S.y_shift), 1);
                    z_target = S.z_init;
                    while sum(x_target) ~= sum(S.x_shift) || ...
                            sum(S.y_shift) ~= 0 || ...
                            sum(z_target) ~= sum(S.z_shift)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_3
                        if sum(x_target) == sum(S.x_shift) && ...
                                sum(S.y_shift) == 0 && ...
                                sum(z_target) == sum(S.z_shift)
                            % Date plot
                            S.xz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_2, f_3
                case '2D: f_2, f_3'
                    delete(S.y_data_r)
                    delete(S.y_vector_r)
                    delete(S.y_polar_r)
                    delete(S.y_cylindrical_r)
                    % z shift
                    S.x_shift = zeros(length(S.x_shift), 1); % Already 0
                    S.y_shift = S.y_init;
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    z_target = S.z_init;
                    while sum(z_target) ~= sum(S.z_shift)
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.yz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [~, ~, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.yz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.yz_data_r)
                        delete(S.yz_vector_r)
                        delete(S.yz_polar_r)
                        delete(S.yz_cylindrical_r)
                        % Last stance of 2D: f_2, f_3
                        if sum(z_target) == sum(S.z_shift)
                            % Date plot
                            S.yz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [~, ~, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.yz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.yz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_2, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_1
                case '1D: f_1'
                    delete(S.y_data_r)
                    delete(S.y_vector_r)
                    delete(S.y_polar_r)
                    delete(S.y_cylindrical_r)
                    % x, y shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % will be shifted.
                    S.y_shift = S.y_init;
                    S.z_shift = zeros(length(S.z_shift), 1); % Already 0
                    x_target = S.x_init;
                    y_target = zeros(length(S.y_shift), 1);
                    while sum(S.y_shift) ~= 0 || ...
                            sum(S.x_shift) ~= sum(S.x_init)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Date plot
                        S.xy_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, ~, ~] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xy_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xy_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xy_data_r)
                        delete(S.xy_polar_r)
                        delete(S.xy_vector_r)
                        delete(S.xy_cylindrical_r)
                        % Last stance of 1D: f_1
                        if sum(S.y_shift) == 0 && ...
                                sum(S.x_shift) == sum(S.x_init)
                            % Data plot
                            S.x_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'r+');
                            % Vector plot
                            [x_1, y_1, ~, ~, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.x_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'r+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'r+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_1')
                    % From-to connection for next plot
                    S.from = '1D: f_1';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_3
                case '1D: f_3'
                    delete(S.y_data_r)
                    delete(S.y_vector_r)
                    delete(S.y_polar_r)
                    delete(S.y_cylindrical_r)
                    % y, z shift
                    S.x_shift = zeros(length(S.x_shift), 1); % Already 0
                    S.y_shift = S.y_init; % will be shifted.
                    S.z_shift = ...
                        zeros(length(S.z_shift), 1); % will be shifted.
                    y_target = zeros(length(S.y_shift), 1);
                    z_target = S.z_init;
                    while sum(S.y_shift) ~= 0 || ...
                            sum(S.z_shift) ~= sum(S.z_init)
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.yz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [~, ~, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.yz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.yz_data_r)
                        delete(S.yz_vector_r)
                        delete(S.yz_polar_r)
                        delete(S.yz_cylindrical_r)
                        % Last stance of 1D: f_3
                        if sum(S.y_shift) == 0 && ...
                                sum(S.z_shift) == sum(S.z_init)
                            % Data plot
                            S.z_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'b+');
                            % Vector plot
                            [~, ~, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.z_vector_r = plot3(S.ax_vector_r, ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'b+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.z_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'b+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_3')
                    % From-to connection for next plot
                    S.from = '1D: f_3';
                    % Updating S
                    updating_r(S)
            end
            
            
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % From 1D (f_3) to others: 6 cases
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        elseif strcmp(S.from, '1D: f_3')
            switch S.to
                
                %%% To 3D: f_1, f_2, f_3
                case '3D: f_1, f_2, f_3'
                    delete(S.z_data_r)
                    delete(S.z_vector_r)
                    delete(S.z_polar_r)
                    delete(S.z_cylindrical_r)
                    % x, y shift
                    S.x_shift = zeros(...
                        length(S.x_shift), 1); % will be shifted.
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init;
                    x_target = S.x_init;
                    y_target = S.y_init;
                    while sum(S.x_shift) ~= sum(x_target) || ...
                            sum(S.y_shift) ~= sum(y_target)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Data plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 3D: f_1, f_2, f_3
                        if sum(S.x_shift) == sum(x_target) && ...
                                sum(S.y_shift) == sum(y_target)
                            % Data plot
                            S.xyz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xyz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xyz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '3D: f_1, f_2, f_3')
                    % From-to connection for next plot
                    S.from = '3D: f_1, f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_2
                case '2D: f_1, f_2'
                    delete(S.z_data_r)
                    delete(S.z_vector_r)
                    delete(S.z_polar_r)
                    delete(S.z_cylindrical_r)
                    % x, y, z shift
                    S.x_shift = zeros(...
                        length(S.x_shift), 1); % will be shifted.
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init; % will be shifted.
                    x_target = S.x_init;
                    y_target = S.y_init;
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.z_shift) ~= 0 || ...
                            sum(x_target) ~= sum(S.x_shift) || ...
                            sum(y_target) ~= sum(S.y_shift)
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Date plot
                        S.xyz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xyz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xyz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xyz_data_r)
                        delete(S.xyz_vector_r)
                        delete(S.xyz_cylindrical_r)
                        % Last stance of 2D: f_1, f_2
                        if sum(S.z_shift) == 0 && ...
                                sum(x_target) == sum(S.x_shift) && ...
                                sum(y_target) == sum(S.y_shift)
                            % Data plot
                            S.xy_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xy_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xy_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_2')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_2';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_1, f_3
                case '2D: f_1, f_3'
                    delete(S.z_data_r)
                    delete(S.z_vector_r)
                    delete(S.z_polar_r)
                    delete(S.z_cylindrical_r)
                    % x shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % will be shifted.
                    S.y_shift = zeros(length(S.y_shift), 1); % Already 0
                    S.z_shift = S.z_init;
                    x_target = S.x_init;
                    while sum(x_target) ~= sum(S.x_shift)
                        S.x_shift = shifting(S.x_shift, x_target);
                        % Date plot
                        S.xz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, ~, ~, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(...
                            S.x_shift, S.y_shift, S.z_shift);
                        S.xz_cylindrical_r = plot3(...
                            S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xz_data_r)
                        delete(S.xz_vector_r)
                        delete(S.xz_polar_r)
                        delete(S.xz_cylindrical_r)
                        % Last stance of 2D: f_1, f_3
                        if sum(x_target) == sum(S.x_shift)
                            % Date plot
                            S.xz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [x_1, y_1, ~, ~, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.xz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.xz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_1, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_1, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 2D: f_2, f_3
                case '2D: f_2, f_3'
                    delete(S.z_data_r)
                    delete(S.z_vector_r)
                    delete(S.z_polar_r)
                    delete(S.z_cylindrical_r)
                    % y shift
                    S.x_shift = zeros(length(S.x_shift), 1); % Already 0
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init;
                    y_target = S.y_init;
                    while sum(y_target) ~= sum(S.y_shift)
                        S.y_shift = shifting(S.y_shift, y_target);
                        % Data plot
                        S.yz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [~, ~, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.yz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.yz_data_r)
                        delete(S.yz_vector_r)
                        delete(S.yz_polar_r)
                        delete(S.yz_cylindrical_r)
                        % Last stance of 2D: f_2, f_3
                        if sum(y_target) == sum(S.y_shift)
                            % Data plot
                            S.yz_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'm+');
                            % Vector plot
                            [~, ~, x_2, y_2, y_3, z_3] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.yz_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                [0, 0], [0, y_3], [0, z_3], 'b-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.yz_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'm+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.yz_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'm+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '2D: f_2, f_3')
                    % From-to connection for next plot
                    S.from = '2D: f_2, f_3';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_1
                case '1D: f_1'
                    delete(S.z_data_r)
                    delete(S.z_vector_r)
                    delete(S.z_polar_r)
                    delete(S.z_cylindrical_r)
                    % x, z shift
                    S.x_shift = ...
                        zeros(length(S.x_shift), 1); % will be shifted.
                    S.y_shift = zeros(length(S.y_shift), 1); % Already 0
                    S.z_shift = S.z_init; % will be shifted.
                    x_target = S.x_init;
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.x_shift) ~= sum(S.x_init) || ...
                            sum(S.z_shift) ~= 0
                        S.x_shift = shifting(S.x_shift, x_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.xz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [x_1, y_1, ~, ~, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.xz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_1], [0, y_1], [0, 0], 'r-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.xz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.xz_data_r)
                        delete(S.xz_vector_r)
                        delete(S.xz_polar_r)
                        delete(S.xz_cylindrical_r)
                        % Last stance of 1D: f_1
                        if sum(S.x_shift) == sum(S.x_init) && ...
                                sum(S.z_shift) == 0
                            % Data plot
                            S.x_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'r+');
                            % Vector plot
                            [x_1, y_1, ~, ~, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.x_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_1], [0, y_1], [0, 0], 'r-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'r+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(S.x_shift, S.y_shift, S.z_shift);
                            S.x_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'r+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_1')
                    % From-to connection for next plot
                    S.from = '1D: f_1';
                    % Updating S
                    updating_r(S)
                    
                    %%% To 1D: f_2
                case '1D: f_2'
                    delete(S.z_data_r)
                    delete(S.z_vector_r)
                    delete(S.z_polar_r)
                    delete(S.z_cylindrical_r)
                    % y, z shift
                    S.x_shift = zeros(length(S.x_shift), 1); % Already 0
                    S.y_shift = zeros(...
                        length(S.y_shift), 1); % will be shifted.
                    S.z_shift = S.z_init; % will be shifted.
                    y_target = S.y_init;
                    z_target = zeros(length(S.z_shift), 1);
                    while sum(S.z_shift) ~= 0 || ...
                            sum(S.y_shift) ~= sum(S.y_init)
                        S.y_shift = shifting(S.y_shift, y_target);
                        S.z_shift = shifting(S.z_shift, z_target);
                        % Data plot
                        S.yz_data_r = plot3(S.ax_data_r, ...
                            S.x_shift, S.y_shift, S.z_shift, 'm+');
                        % Vector plot
                        [~, ~, x_2, y_2, y_3, z_3] = ...
                            vectorizing(...
                            S.x_shift, S.y_shift, S.z_shift, ...
                            S.x_init, S.y_init, S.z_init);
                        S.yz_vector_r = plot3(S.ax_vector_r, ...
                            [0, x_2], [0, y_2], [0, 0], 'g-', ...
                            [0, 0], [0, y_3], [0, z_3], 'b-', ...
                            'linewidth', 3);
                        % Polar plot
                        [theta, rho, ~] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_polar_r = polarplot(S.ax_polar_r, ...
                            theta, rho, 'm+');
                        % Cylindrical plot
                        [theta, rho, z] = ...
                            cart2pol(S.x_shift, S.y_shift, S.z_shift);
                        S.yz_cylindrical_r = plot3(S.ax_cylindrical_r, ...
                            theta, rho, z, 'm+');
                        % Renewing
                        drawnow
                        delete(S.yz_data_r)
                        delete(S.yz_vector_r)
                        delete(S.yz_polar_r)
                        delete(S.yz_cylindrical_r)
                        % Last stance of 1D: f_2
                        if sum(S.z_shift) == 0 && ...
                                sum(S.y_shift) == sum(S.y_init)
                            % Data plot
                            S.y_data_r = plot3(S.ax_data_r, ...
                                S.x_shift, S.y_shift, S.z_shift, 'g+');
                            % Vector plot
                            [~, ~, x_2, y_2, ~, ~] = ...
                                vectorizing(...
                                S.x_shift, S.y_shift, S.z_shift, ...
                                S.x_init, S.y_init, S.z_init);
                            S.y_vector_r = plot3(S.ax_vector_r, ...
                                [0, x_2], [0, y_2], [0, 0], 'g-', ...
                                'linewidth', 3);
                            % Polar plot
                            [theta, rho, ~] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_polar_r = polarplot(S.ax_polar_r, ...
                                theta, rho, 'g+');
                            % Cylindrical plot
                            [theta, rho, z] = ...
                                cart2pol(...
                                S.x_shift, S.y_shift, S.z_shift);
                            S.y_cylindrical_r = plot3(...
                                S.ax_cylindrical_r, ...
                                theta, rho, z, 'g+');
                        end
                    end
                    % Escaping string
                    set(S.et_process_r, 'string', '1D: f_2')
                    % From-to connection for next plot
                    S.from = '1D: f_2';
                    % Updating S
                    updating_r(S)
            end
        end
    end





%% Updating S %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%
% Real version
%%%%%%%%%%%%%%
    function updating_r(S)
        set(S.slide_rc, 'callback', {@slide_rc_callback, S})
        set(S.pb_init_r, 'callback', {@pb_init_r_callback, S})
        set(S.pb_xyz_r, 'callback', {@pb_xyz_r_callback, S})
        set(S.pb_xy_r, 'callback', {@pb_xy_r_callback, S})
        set(S.pb_yz_r, 'callback', {@pb_yz_r_callback, S})
        set(S.pb_xz_r, 'callback', {@pb_xz_r_callback, S})
        set(S.pb_x_r, 'callback', {@pb_x_r_callback, S})
        set(S.pb_y_r, 'callback', {@pb_y_r_callback, S})
        set(S.pb_z_r, 'callback', {@pb_z_r_callback, S})
        set(S.pb_reset_r, 'callback', {@pb_reset_r_callback, S})
    end



%%%%%%%%%%%%%%%%%
% Complex version
%%%%%%%%%%%%%%%%%
    function updating_c(S)
        set(S.slide_rc, 'callback', {@slide_rc_callback, S})
        set(S.pb_init_c, 'callback', {@pb_init_c_callback, S})
        set(S.pb_xy_c, 'callback', {@pb_xy_c_callback, S})
        set(S.pb_reset_c, 'callback', {@pb_reset_c_callback, S})
    end






%% Shifting & Vectorizing %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%
% Shifting
%%%%%%%%%%
    function shifted_coordinate = shifting(...
            curr_coordinate, target_coordinate)
        % Dummy output to be stacked
        shifted_coordinate = zeros(length(curr_coordinate), 1);
        
        %%% Shifting loop
        for row = 1:length(curr_coordinate)
            % When there is no big differences, sink them.
            if abs(curr_coordinate(row) - target_coordinate(row)) < 0.1
                curr_coordinate(row) = target_coordinate(row);
                % When current point has to grow, proceed.
            elseif curr_coordinate(row) < target_coordinate(row)
                curr_coordinate(row) = curr_coordinate(row) + 0.1;
                % When current point has to be lowered, proceed.
            elseif curr_coordinate(row) > target_coordinate(row)
                curr_coordinate(row) = curr_coordinate(row) - 0.1;
            end
            % Stacking the shifted output
            shifted_coordinate(row) = curr_coordinate(row);
        end
    end



%%%%%%%%%%%%%%%%%%%%
% Vector coordinates
%%%%%%%%%%%%%%%%%%%%
% radian_x_y = acos(dot(x, y) / (norm(x) * norm(y)))
% corr(x, y) = r_y_z = cos(radian_y_z);
    function varargout = vectorizing(varargin)
        
        %%% Proceed only with 6 inputs.
        if nargin == 6
            f_1 = varargin{1};
            f_2 = varargin{2};
            f_3 = varargin{3};
            f_1_o = varargin{4};
            f_2_o = varargin{5};
            f_3_o = varargin{6};
            
            %%% Substituting data
            % When any the inputs is zero, then
            % fetch the original data to get the angles.
            if sum(f_1) == 0
                f_1_prev = f_1;
                f_1 = f_1_o;
            end
            if sum(f_2) == 0
                f_2_prev = f_2;
                f_2 = f_2_o;
            end
            if sum(f_3) == 0
                f_3_prev = f_3;
                f_3 = f_3_o;
            end
            
            %%% Main vector calculation (relative positions)
            x_1 = norm(f_1);
            y_1 = 0;
            x_2 = norm(f_2) * cos(acos(corr(f_1, f_2)));
            y_2 = norm(f_2) * sin(acos(corr(f_1, f_2)));
            y_3 = norm(f_3) * cos(acos(corr(f_2, f_3)));
            z_3 = norm(f_3) * sin(acos(corr(f_2, f_3)));
            
            %%% Adjustments for the above substitutions
            % The norms have to be re-adjusted after we extract the angles.
            try
                if sum(f_1_prev) == 0
                    x_1 = 0;
                    y_1 = 0;
                end
            catch
            end
            try
                if sum(f_2_prev) == 0
                    x_2 = 0;
                    y_2 = 0;
                end
            catch
            end
            try
                if sum(f_3_prev) == 0
                    y_3 = 0;
                    z_3 = 0;
                end
            catch
            end
            
            %%% 6 Outputs
            varargout{1} = x_1;
            varargout{2} = y_1;
            varargout{3} = x_2;
            varargout{4} = y_2;
            varargout{5} = y_3;
            varargout{6} = z_3;
            
            %%% Return when improper numbers of inputs are given.
        else
            return
        end
    end
end